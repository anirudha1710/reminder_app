import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/reminder_provider.dart';
import '../widgets/reminder_item.dart';

class ReminderListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reminders = ref.watch(reminderProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Reminders')),
      body: ListView.builder(
        itemCount: reminders.length,
        itemBuilder: (context, index) {
          return ReminderItem(reminder: reminders[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add'),
        child: Icon(Icons.add),
      ),
    );
  }
}