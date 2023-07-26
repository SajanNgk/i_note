import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_note/model/note_model.dart';
import 'package:i_note/viewmodel/expanded_date_notifier.dart';
import 'package:i_note/viewmodel/note_model_view.dart';

final noteStateNotifierProvider =
    StateNotifierProvider<NoteStateNotifier, List<Note>>((ref) {
  return NoteStateNotifier();
});

final expandedDatesProvider = StateNotifierProvider<ExpandedDatesNotifier, Set<String>>(
  (ref) => ExpandedDatesNotifier(),
);

