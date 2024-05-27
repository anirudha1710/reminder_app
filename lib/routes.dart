import 'package:flutter/material.dart';
import 'package:reminder_app/presentation/screens/add_edit_reminder_screen.dart';
import 'package:reminder_app/presentation/screens/reminder_list_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => ReminderListScreen(),
  '/add': (context) => AddEditReminderScreen(),
  '/edit': (context) => AddEditReminderScreen(isEdit: true),
};
