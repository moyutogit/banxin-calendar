import 'dart:convert';

import 'package:banxin_calendar/core/time/app_clock.dart';
import 'package:banxin_calendar/features/alarm/domain/alarm_repository.dart';
import 'package:banxin_calendar/features/assistant/application/assistant_action_gateway.dart';
import 'package:banxin_calendar/features/assistant/domain/assistant_entities.dart';
import 'package:banxin_calendar/features/assistant/domain/capability_knowledge_source.dart';
import 'package:banxin_calendar/features/schedule/application/schedule_application_service.dart';
import 'package:banxin_calendar/features/schedule/domain/value_objects.dart';
import 'package:banxin_calendar/features/statistics/application/statistics_service.dart';

final class ToolPermissionException implements Exception {
  const ToolPermissionException(this.scope);

  final String scope;
}

final class ToolGateway {
  const ToolGateway(
    this._knowledge,
    this._schedule,
    this._statistics,
    this._alarms,
    this._actions, {
    this._clock = const SystemAppClock(),
  });

  final CapabilityKnowledgeSource _knowledge;
  final ScheduleApplicationService _schedule;
  final StatisticsService _statistics;
  final AlarmRepository _alarms;
  final AssistantActionGateway _actions;
  final AppClock _clock;

  static const Set<String> supportedTools = <String>{
    'get_app_capabilities',
    'get_schedule',
    'get_attendance_summary',
    'get_wage_summary',
    'get_alarm_summary',
    'propose_schedule_change',
    'apply_schedule_change',
    'undo_ai_action',
  };

  Future<Map<String, Object?>> execute({
    required String name,
    required Map<String, Object?> arguments,
    required AssistantPersona persona,
    required String conversationId,
  }) async {
    if (!supportedTools.contains(name)) {
      throw UnsupportedError('Unsupported assistant tool.');
    }
    return switch (name) {
      'get_app_capabilities' => <String, Object?>{
        'capabilities': jsonDecode(await _knowledge.capabilities()),
      },
      'get_schedule' => _getSchedule(arguments, persona.scopes),
      'get_attendance_summary' => _getStatistics(
        arguments,
        persona.scopes,
        includeWage: false,
      ),
      'get_wage_summary' => _getStatistics(
        arguments,
        persona.scopes,
        includeWage: true,
      ),
      'get_alarm_summary' => _getAlarms(persona.scopes),
      'propose_schedule_change' => _propose(conversationId, arguments),
      'apply_schedule_change' => _apply(arguments),
      'undo_ai_action' => _undo(arguments),
      _ => throw UnsupportedError('Unsupported assistant tool.'),
    };
  }

  Future<Map<String, Object?>> _getSchedule(
    Map<String, Object?> arguments,
    AssistantDataScopes scopes,
  ) async {
    if (!scopes.scheduleRead) throw const ToolPermissionException('schedule');
    final range = _range(arguments);
    final calendar = await _schedule.loadCalendar(range);
    return <String, Object?>{
      'range': <String, String>{
        'start': range.start.toString(),
        'end': range.end.toString(),
      },
      'configured': calendar.configured,
      'days': <Object?>[
        for (final day in calendar.days)
          <String, Object?>{
            'date': day.date.toString(),
            'status': day.status.name,
            'shift': day.shift?.name,
            'plannedMinutes': day.plannedPaidMinutes,
          },
      ],
    };
  }

  Future<Map<String, Object?>> _getStatistics(
    Map<String, Object?> arguments,
    AssistantDataScopes scopes, {
    required bool includeWage,
  }) async {
    if (!scopes.attendanceRead) {
      throw const ToolPermissionException('attendance');
    }
    if (includeWage && !scopes.wageRead) {
      throw const ToolPermissionException('wage');
    }
    final report = await _statistics.build(_range(arguments));
    return <String, Object?>{
      'expectedAttendanceDays': report.expectedAttendanceDays,
      'actualAttendanceDays': report.actualAttendanceDays,
      'actualMinutes': report.rawActualMinutes,
      'normalMinutes': report.normalMinutes,
      'overtimeMinutes': report.overtimeMinutes,
      'missingPunchCount': report.missingPunchCount,
      if (includeWage)
        'wage': report.payroll == null
            ? <String, Object?>{'configured': false}
            : <String, Object?>{
                'configured': true,
                'currency': report.payroll!.currency,
                'estimatedTotalMinor': report.payroll!.estimatedTotalMinor,
              },
    };
  }

  Future<Map<String, Object?>> _getAlarms(AssistantDataScopes scopes) async {
    if (!scopes.alarmRead) throw const ToolPermissionException('alarm');
    final alarms = await _alarms.loadUpcomingInstances(_clock.nowUtc());
    return <String, Object?>{
      'upcomingCount': alarms.length,
      'failedCount': alarms
          .where((alarm) => alarm.status.name == 'failed')
          .length,
      'nextScheduleDate': alarms.firstOrNull?.scheduleDate.toString(),
    };
  }

  Future<Map<String, Object?>> _propose(
    String conversationId,
    Map<String, Object?> arguments,
  ) async {
    final proposal = await _actions.proposeScheduleChange(
      conversationId: conversationId,
      arguments: arguments,
    );
    return <String, Object?>{
      'requiresConfirmation': true,
      'actionId': proposal.action.id,
      'confirmationToken': proposal.confirmationToken,
      'summary': proposal.summary,
      'expiresAt': proposal.action.expiresAtUtc.toIso8601String(),
    };
  }

  Future<Map<String, Object?>> _apply(Map<String, Object?> arguments) async {
    final actionId = arguments['action_id'];
    final token = arguments['confirmation_token'];
    if (actionId is! String || token is! String) {
      throw const AssistantActionException('explicit_confirmation_required');
    }
    final action = await _actions.confirmScheduleChange(
      actionId: actionId,
      confirmationToken: token,
    );
    return <String, Object?>{
      'succeeded': action.status == AiActionStatus.succeeded,
      'actionId': action.id,
      'undoAvailable': true,
    };
  }

  Future<Map<String, Object?>> _undo(Map<String, Object?> arguments) async {
    final actionId = arguments['action_id'];
    if (actionId is! String) {
      throw const AssistantActionException('action_id_required');
    }
    final action = await _actions.undoScheduleChange(actionId);
    return <String, Object?>{
      'undone': action.status == AiActionStatus.undone,
      'actionId': action.id,
    };
  }

  DateRange _range(Map<String, Object?> arguments) {
    final raw = arguments['range'];
    if (raw is! Map<String, Object?> ||
        raw['start'] is! String ||
        raw['end'] is! String) {
      throw const FormatException('Explicit ISO date range is required.');
    }
    final range = DateRange(
      start: LocalDate.parse(raw['start']! as String),
      end: LocalDate.parse(raw['end']! as String),
    );
    if (range.start.daysUntil(range.end) > 365) {
      throw const FormatException('Date range exceeds one year.');
    }
    return range;
  }
}
