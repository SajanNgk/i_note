import 'dart:async';
import 'package:i_note/model/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Future<Database> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'notes.db');

    return await openDatabase(
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

  static Future<int?> insert(Note note) async {
    final db = await initDatabase();
    return await db.insert('notes', note.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Note>> getNotes() async {
    final db = await initDatabase();
    final List<Map<String, dynamic>> maps = await db.query('notes');

    return List.generate(maps.length, (i) {
      return Note(
        id: maps[i]['id'],
        title: maps[i]['title'],
        body: maps[i]['body'],
        createdAt: DateTime.parse(maps[i]['createdAt']),
      );
    });
  }

  static Future<int?> delete(int? id) async {
    final db = await initDatabase();
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> update(Note note) async {
    final db = await initDatabase();
    return await db.update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }
}
