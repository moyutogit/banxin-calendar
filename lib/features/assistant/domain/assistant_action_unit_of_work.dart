import 'package:banxin_calendar/features/assistant/domain/assistant_entities.dart';

abstract interface class AssistantActionUnitOfWork {
  Future<void> execute({
    required AiAction executing,
    required Future<AiAction> Function() operation,
  });
}
