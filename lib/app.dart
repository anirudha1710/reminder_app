import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/screens/add_edit_reminder_screen.dart';
import 'presentation/screens/reminder_detail_screen.dart';
import 'presentation/screens/reminder_list_screen.dart';

class ReminderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Reminder App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => ReminderListScreen(),
          '/add': (context) => AddEditReminderScreen(),
          '/edit': (context) => AddEditReminderScreen(isEdit: true),
          '/detail': (context) => ReminderDetailScreen(),
        },
      ),
    );
  }
}

void main() {
  runApp(ReminderApp());
}