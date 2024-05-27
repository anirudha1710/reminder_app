import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/screens/add_edit_reminder_screen.dart';
import 'presentation/screens/reminder_detail_screen.dart';
import 'presentation/screens/reminder_list_screen.dart';
import 'utils/notification_service.dart';

final notificationServiceProvider = Provider((ref) => NotificationService());

class ReminderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Reminder App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false, // Remove debug banner
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter bindings are initialized
  final container = ProviderContainer();
  final notificationService = container.read(notificationServiceProvider);
  await notificationService.initialize(); // Ensure notification service is initialized before runApp()

  runApp(ReminderApp());
}
