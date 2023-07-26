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
            id INTEGER PRIMARY KEY,
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
    await db.insert('notes', note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Note>> getNotes() async {
    final db = await initDatabase();
    final List<Map<String, dynamic>> maps = await db.query('notes');

    return maps.map((map) => Note.fromMap(map)).toList();
  }

  static Future<void> delete(int id) async {
    final db = await initDatabase();
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> update(Note note) async {
    final db = await initDatabase();
    await db.update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }
}
