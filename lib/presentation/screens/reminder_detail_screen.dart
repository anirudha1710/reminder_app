import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/reminder.dart';
import '../providers/reminder_provider.dart';

class ReminderDetailScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reminder = ModalRoute.of(context)!.settings.arguments as Reminder;

    return Scaffold(
      appBar: AppBar(
        title: Text('Reminder Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              ref.read(reminderProvider.notifier).deleteReminder(reminder.id);
              Navigator.of(context).pop();
            },
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(context, '/edit', arguments: reminder);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              reminder.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              reminder.description,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Time: ${reminder.time}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Priority: ${reminder.priority}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}