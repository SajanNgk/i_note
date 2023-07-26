import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpandedDatesNotifier extends StateNotifier<Set<String>> {
  ExpandedDatesNotifier() : super(Set<String>());

  void toggleExpanded(String date) {
    state.contains(date) ? state.remove(date) : state.add(date);
  }
}
