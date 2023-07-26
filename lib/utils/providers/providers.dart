import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_note/model/note_model.dart';
import 'package:i_note/utils/widgets/add_note_widget.dart';
import 'package:i_note/viewmodel/note_model_view.dart';

final notesProvider = StateNotifierProvider<NotesStateNotifier, List<Note>>((ref) => NotesStateNotifier());

final addNoteFormProvider = Provider<AddNoteForm>((ref) {
  return AddNoteForm();
});
