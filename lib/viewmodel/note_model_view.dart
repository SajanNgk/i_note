import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_note/model/note_model.dart';
import 'package:i_note/services/sqlight.dart';

class NoteStateNotifier extends StateNotifier<List<Note>> {
  NoteStateNotifier() : super([]);

  Future<void> fetchNotes() async {
    state = await DatabaseService.getNotes();
  }

  Future<void> add(Note note) async {
    if (note.id == 0) {
      final id = DateTime.now().millisecondsSinceEpoch;
      note = note.copyWith(id: id);
    }
    state = [...state, note];
    await DatabaseService.insert(note);
  }

  Future<void> update(Note updatedNote) async {
    final index = state.indexWhere((note) => note.id == updatedNote.id);
    if (index != -1) {
      state[index] = updatedNote;
      await DatabaseService.update(updatedNote);
    }
  }

  Future<void> delete(int id) async {
    state.removeWhere((note) => note.id == id); 
    await DatabaseService.delete(id); 
  }
}
