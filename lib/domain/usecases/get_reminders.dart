import '../entities/reminder.dart';
import '../../data/repositories/reminder_repository.dart';
import '../../data/models/reminder_model.dart';

class GetReminders {
  final ReminderRepository repository;

  GetReminders(this.repository);

  Future<List<Reminder>> call() async {
    final reminderModels = await repository.getReminders();
    return reminderModels.map((model) => Reminder(
      id: model.id,
      title: model.title,
      description: model.description,
      time: model.time,
      priority: model.priority,
    )).toList();
  }
}
