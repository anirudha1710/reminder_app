import '../entities/reminder.dart';
import '../../data/repositories/reminder_repository.dart';
import '../../data/models/reminder_model.dart';

class GetRemindersByPriority {
  final ReminderRepository repository;

  GetRemindersByPriority(this.repository);

  Future<List<Reminder>> call(String priority) async {
    final reminderModels = await repository.getReminders();
    return reminderModels
        .where((model) => model.priority == priority)
        .map((model) => Reminder(
      id: model.id,
      title: model.title,
      description: model.description,
      time: model.time,
      priority: model.priority,
    ))
        .toList();
  }
}
