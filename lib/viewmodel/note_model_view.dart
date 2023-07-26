import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_note/model/note_model.dart';
import 'package:i_note/services/database_services.dart';

class NotesStateNotifier extends StateNotifier<List<Note>> {
  NotesStateNotifier() : super([]);

  void add(Note note) {
    state = [...state, note];
    DatabaseService().saveNotes(state);
  }

  void update(Note updatedNote) {
    state = state
        .map((note) => note.id == updatedNote.id ? updatedNote : note)
        .toList();
    DatabaseService().saveNotes(state);
  }

  void delete(String id) {
    state = state.where((note) => note.id != id).toList();
    DatabaseService().saveNotes(state);
  }

  void loadNotes() async {
    state = await DatabaseService().getNotes();
  }
}
