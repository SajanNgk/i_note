import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_note/model/note_model.dart';
import 'package:i_note/services/sqlight.dart';
import 'package:uuid/uuid.dart';

class NoteStateNotifier extends StateNotifier<List<Note>> {
  NoteStateNotifier() : super([]);

  Future<void> fetchNotes() async {
    try {
      state = await DatabaseService.getNotes();
    } catch (e) {
      // Handle error here, such as showing an error message or logging the error.
      print('Error fetching notes: $e');
      rethrow; // Re-throw the error so that consumers can handle it if needed.
    }
  }

  Future<void> add(Note note) async {
    final newNote = Note(
      id: Uuid().v4(),
      title: note.title,
      body: note.body,
      createdAt: note.createdAt,
    );

    try {
      state = [...state, newNote];
      await DatabaseService.insert(newNote);
    } catch (e) {
      // Handle error here, such as showing an error message or logging the error.
      print('Error adding note: $e');
      rethrow; // Re-throw the error so that consumers can handle it if needed.
    }
  }

  Future<void> update(Note updatedNote) async {
    final index = state.indexWhere((note) => note.id == updatedNote.id);
    if (index != -1) {
      state[index] = updatedNote;
      try {
        await DatabaseService.update(updatedNote);
      } catch (e) {
        // Handle error here, such as showing an error message or logging the error.
        print('Error updating note: $e');
        rethrow; // Re-throw the error so that consumers can handle it if needed.
      }
    }
  }

  Future<void> delete(String id) async {
    state.removeWhere((note) => note.id == id);
    try {
      await DatabaseService.delete(id);
    } catch (e) {
      // Handle error here, such as showing an error message or logging the error.
      print('Error deleting note: $e');
      rethrow; // Re-throw the error so that consumers can handle it if needed.
    }
  }
}
