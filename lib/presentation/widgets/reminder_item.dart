import 'package:flutter/material.dart';
import '../../domain/entities/reminder.dart';

class ReminderItem extends StatelessWidget {
  final Reminder reminder;

  ReminderItem({required this.reminder});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(reminder.title),
      subtitle: Text('Time: ${reminder.time}\nPriority: ${reminder.priority}'),
      onTap: () {
        Navigator.pushNamed(
          context,
          '/detail',
          arguments: reminder,
        );
      },
    );
  }
}