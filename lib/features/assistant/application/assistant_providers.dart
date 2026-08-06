import 'package:banxin_calendar/core/database/database_providers.dart';
import 'package:banxin_calendar/core/secure_storage/secure_storage_providers.dart';
import 'package:banxin_calendar/features/alarm/application/alarm_providers.dart';
import 'package:banxin_calendar/features/assistant/application/assistant_action_gateway.dart';
import 'package:banxin_calendar/features/assistant/application/assistant_settings_service.dart';
import 'package:banxin_calendar/features/assistant/application/conversation_service.dart';
import 'package:banxin_calendar/features/assistant/application/tool_gateway.dart';
import 'package:banxin_calendar/features/assistant/data/asset_capability_knowledge_source.dart';
import 'package:banxin_calendar/features/assistant/data/dart_io_llm_provider.dart';
import 'package:banxin_calendar/features/assistant/data/drift_assistant_action_unit_of_work.dart';
import 'package:banxin_calendar/features/assistant/data/drift_assistant_repository.dart';
import 'package:banxin_calendar/features/assistant/domain/assistant_action_unit_of_work.dart';
import 'package:banxin_calendar/features/assistant/domain/assistant_repository.dart';
import 'package:banxin_calendar/features/assistant/domain/capability_knowledge_source.dart';
import 'package:banxin_calendar/features/assistant/domain/llm_provider.dart';
import 'package:banxin_calendar/features/assistant/domain/provider_config_validator.dart';
import 'package:banxin_calendar/features/schedule/application/schedule_providers.dart';
import 'package:banxin_calendar/features/statistics/application/workforce_providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final assistantRepositoryProvider = Provider<AssistantRepository>(
  (ref) => DriftAssistantRepository(ref.watch(appDatabaseProvider)),
);

final llmProviderProvider = Provider<LlmProvider>(
  (ref) => const DartIoLlmProvider(),
);

final capabilityKnowledgeSourceProvider = Provider<CapabilityKnowledgeSource>(
  (ref) => const AssetCapabilityKnowledgeSource(),
);

final assistantActionUnitOfWorkProvider = Provider<AssistantActionUnitOfWork>(
  (ref) => DriftAssistantActionUnitOfWork(
    ref.watch(appDatabaseProvider),
    ref.watch(assistantRepositoryProvider),
  ),
);

final assistantActionGatewayProvider = Provider<AssistantActionGateway>(
  (ref) => AssistantActionGateway(
    ref.watch(assistantRepositoryProvider),
    ref.watch(assistantActionUnitOfWorkProvider),
    ref.watch(scheduleRepositoryProvider),
    ref.watch(scheduleApplicationServiceProvider),
    ref.watch(secureValueStoreProvider),
    syncAlarms: () async {
      final result = await ref
          .read(alarmApplicationServiceProvider)
          .syncRollingWindow();
      return result.failed == 0;
    },
    alarmRepository: ref.watch(alarmRepositoryProvider),
  ),
);

final toolGatewayProvider = Provider<ToolGateway>(
  (ref) => ToolGateway(
    ref.watch(capabilityKnowledgeSourceProvider),
    ref.watch(scheduleApplicationServiceProvider),
    ref.watch(statisticsServiceProvider),
    ref.watch(alarmRepositoryProvider),
    ref.watch(assistantActionGatewayProvider),
  ),
);

final assistantSettingsServiceProvider = Provider<AssistantSettingsService>(
  (ref) => AssistantSettingsService(
    ref.watch(assistantRepositoryProvider),
    ref.watch(secureCredentialServiceProvider),
    ref.watch(llmProviderProvider),
    validator: ProviderConfigValidator(allowInsecureHttp: !kReleaseMode),
  ),
);

final conversationServiceProvider = Provider<ConversationService>(
  (ref) => ConversationService(
    ref.watch(assistantRepositoryProvider),
    ref.watch(assistantSettingsServiceProvider),
    ref.watch(llmProviderProvider),
    ref.watch(capabilityKnowledgeSourceProvider),
    ref.watch(toolGatewayProvider),
  ),
);
