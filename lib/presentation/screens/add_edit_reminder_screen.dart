import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/main.dart';
import '../../domain/entities/reminder.dart';
import '../providers/reminder_provider.dart';

class AddEditReminderScreen extends ConsumerStatefulWidget {
  final bool isEdit;
  final Reminder? reminder;

  AddEditReminderScreen({this.isEdit = false, this.reminder});

  @override
  _AddEditReminderScreenState createState() => _AddEditReminderScreenState();
}

class _AddEditReminderScreenState extends ConsumerState<AddEditReminderScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late DateTime _date;
  late TimeOfDay _time;
  late String _priority;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.reminder != null) {
      _title = widget.reminder!.title;
      _description = widget.reminder!.description;
      _date = widget.reminder!.time;
      _time = TimeOfDay.fromDateTime(widget.reminder!.time);
      _priority = widget.reminder!.priority;
    } else {
      _title = '';
      _description = '';
      _date = DateTime.now();
      _time = TimeOfDay.now();
      _priority = 'Low';
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
      });
    }
  }

  void _saveReminder() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final DateTime combinedDateTime = DateTime(
        _date.year,
        _date.month,
        _date.day,
        _time.hour,
        _time.minute,
      );

      if (widget.isEdit && widget.reminder != null) {
        ref.read(reminderProvider.notifier).updateReminder(
          widget.reminder!.id,
          _title,
          _description,
          combinedDateTime,
          _priority,
        );
      } else {
        final newReminder = Reminder(
          id: DateTime.now().toString(),
          title: _title,
          description: _description,
          time: combinedDateTime,
          priority: _priority,
        );

        ref.read(reminderProvider.notifier).addReminder(
          newReminder.title,
          newReminder.description,
          newReminder.time,
          newReminder.priority,
        );

        // Schedule notification
        final notificationService = ref.read(notificationServiceProvider);
        notificationService.scheduleNotification(
          newReminder.id,
          newReminder.title,
          newReminder.description,
          newReminder.time,
        );
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Edit Reminder' : 'Add Reminder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) => _title = value!,
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) => _description = value!,
              ),
              ListTile(
                title: Text('Date: ${DateFormat.yMd().format(_date)}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
              ListTile(
                title: Text('Time: ${_time.format(context)}'),
                trailing: Icon(Icons.access_time),
                onTap: () => _selectTime(context),
              ),
              DropdownButtonFormField<String>(
                value: _priority,
                decoration: InputDecoration(labelText: 'Priority'),
                items: ['Low', 'Medium', 'High'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {},
                onSaved: (value) => _priority = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveReminder,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
