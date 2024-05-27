import '../entities/reminder.dart';
import '../../data/repositories/reminder_repository.dart';
import '../../data/models/reminder_model.dart';

class AddReminder {
  final ReminderRepository repository;

  AddReminder(this.repository);

  Future<void> call(Reminder reminder) async {
    final reminderModel = ReminderModel(
      id: reminder.id,
      title: reminder.title,
      description: reminder.description,
      time: reminder.time,
      priority: reminder.priority,
    );
    await repository.insertReminder(reminderModel);
  }
}
