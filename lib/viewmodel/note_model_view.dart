import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_note/model/note_model.dart';
import 'package:i_note/services/sqlight.dart';

class NoteStateNotifier extends StateNotifier<List<Note>> {
  NoteStateNotifier() : super([]);

  Future<void> fetchNotes() async {
    state = await DatabaseService.getNotes();
  }

  void add(Note note) async {
    state.add(note);
    await DatabaseService.insert(note);
  }

  void update(Note updatedNote) async {
    final index = state.indexWhere((note) => note.id == updatedNote.id);
    if (index != -1) {
      state[index] = updatedNote;
      await DatabaseService.update(updatedNote);
    }
  }

  void delete(int? id) async {
    await DatabaseService.delete(id);
    state.removeWhere((note) => note.id == id);
  }
}
