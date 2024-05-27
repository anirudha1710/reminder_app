
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/reminder.dart';
import 'dart:collection';

class ReminderNotifier extends StateNotifier<List<Reminder>> {
  ReminderNotifier() : super([]);

  void addReminder(String title, String description, DateTime time, String priority) {
    state = [
      ...state,
      Reminder(
        id: DateTime.now().toString(),
        title: title,
        description: description,
        time: time,
        priority: priority,
      )
    ];
  }

  void updateReminder(String id, String title, String description, DateTime time, String priority) {
    state = [
      for (final reminder in state)
        if (reminder.id == id)
          Reminder(
            id: id,
            title: title,
            description: description,
            time: time,
            priority: priority,
          )
        else
          reminder,
    ];
  }

  void deleteReminder(String id) {
    state = state.where((reminder) => reminder.id != id).toList();
  }

  UnmodifiableListView<Reminder> get reminders => UnmodifiableListView(state);
}

final reminderProvider = StateNotifierProvider<ReminderNotifier, List<Reminder>>((ref) {
  return ReminderNotifier();
});
