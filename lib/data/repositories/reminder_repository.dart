import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/reminder_model.dart';

class ReminderRepository {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'reminder.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE reminders(
            id TEXT PRIMARY KEY,
            title TEXT,
            description TEXT,
            time TEXT,
            priority TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertReminder(ReminderModel reminder) async {
    final db = await database;
    await db.insert('reminders', reminder.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<ReminderModel>> getReminders() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('reminders');
    return List.generate(maps.length, (i) => ReminderModel.fromMap(maps[i]));
  }

  Future<void> updateReminder(ReminderModel reminder) async {
    final db = await database;
    await db.update('reminders', reminder.toMap(), where: 'id = ?', whereArgs: [reminder.id]);
  }

  Future<void> deleteReminder(String id) async {
    final db = await database;
    await db.delete('reminders', where: 'id = ?', whereArgs: [id]);
  }
}
