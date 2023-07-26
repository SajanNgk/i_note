import 'package:i_note/model/note_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Future<Database> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'notes.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE notes (
            id TEXT PRIMARY KEY,
            title TEXT,
            body TEXT,
            createdAt TEXT
          )
        ''');
      },
    );
  }

  static Future<void> insert(Note note) async {
    final db = await initDatabase();
    await db.insert(
      'notes',
      {
        'id': note.id,
        'title': note.title,
        'body': note.body,
        'createdAt': note.createdAt.toUtc().toIso8601String(), // Store createdAt as UTC ISO 8601 string
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> update(Note note) async {
    final db = await initDatabase();
    await db.update(
      'notes',
      {
        'id': note.id,
        'title': note.title,
        'body': note.body,
        'createdAt': note.createdAt.toUtc().toIso8601String(), // Store createdAt as UTC ISO 8601 string
      },
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  static Future<List<Note>> getNotes() async {
    final db = await initDatabase();
    try {
      final List<Map<String, dynamic>> maps = await db.query('notes');
      return maps.map((map) => Note.fromMap(map)).toList();
    } catch (e) {
      // Handle error here, such as showing an error message.
      print('Error getting notes: $e');
      return [];
    }
  }

  static Future<void> delete(String id) async {
    final db = await initDatabase();
    try {
      await db.delete('notes', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      // Handle error here, such as showing an error message.
      print('Error deleting note: $e');
    }
  }
}
