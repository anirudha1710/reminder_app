import 'package:flutter/material.dart';

class ReminderForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String title;
  final String description;
  final DateTime time;
  final String priority;
  final Function(String) onSavedTitle;
  final Function(String) onSavedDescription;
  final Function(DateTime) onSavedTime;
  final Function(String) onSavedPriority;
  final Function() onSubmit;

  ReminderForm({
    required this.formKey,
    required this.title,
    required this.description,
    required this.time,
    required this.priority,
    required this.onSavedTitle,
    required this.onSavedDescription,
    required this.onSavedTime,
    required this.onSavedPriority,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            initialValue: title,
            decoration: InputDecoration(labelText: 'Title'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
            onSaved: (value) => onSavedTitle(value!),
          ),
          TextFormField(
            initialValue: description,
            decoration: InputDecoration(labelText: 'Description'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a description';
              }
              return null;
            },
            onSaved: (value) => onSavedDescription(value!),
          ),
          TextFormField(
            initialValue: time.toIso8601String(),
            decoration: InputDecoration(labelText: 'Time'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a time';
              }
              return null;
            },
            onSaved: (value) => onSavedTime(DateTime.parse(value!)),
          ),
          DropdownButtonFormField<String>(
            value: priority,
            decoration: InputDecoration(labelText: 'Priority'),
            items: ['Low', 'Medium', 'High'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {},
            onSaved: (value) => onSavedPriority(value!),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: onSubmit,
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
