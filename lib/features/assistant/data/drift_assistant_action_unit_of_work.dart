import 'package:banxin_calendar/core/database/app_database.dart'
    show AppDatabase;
import 'package:banxin_calendar/features/assistant/domain/assistant_action_unit_of_work.dart';
import 'package:banxin_calendar/features/assistant/domain/assistant_entities.dart';
import 'package:banxin_calendar/features/assistant/domain/assistant_repository.dart';

final class DriftAssistantActionUnitOfWork
    implements AssistantActionUnitOfWork {
  const DriftAssistantActionUnitOfWork(this._database, this._repository);

  final AppDatabase _database;
  final AssistantRepository _repository;

  @override
  Future<void> execute({
    required AiAction executing,
    required Future<AiAction> Function() operation,
  }) {
    return _database.transaction(() async {
      await _repository.saveAction(executing);
      final succeeded = await operation();
      await _repository.saveAction(succeeded);
    });
  }
}
