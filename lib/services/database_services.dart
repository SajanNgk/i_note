import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:i_note/model/note_model.dart';

class DatabaseService {
  static const _notesKey = 'notes';

  Future<List<Note>> getNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = prefs.getString(_notesKey) ?? '[]';
    final notesList = (await Future.wait(jsonDecode(notesJson).map((json) => Note.fromJson(json)))).cast<Note>();
    return notesList;
  }

  Future<void> saveNotes(List<Note> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = jsonEncode(notes.map((note) => note.toJson()).toList());
    await prefs.setString(_notesKey, notesJson);
  }
}
