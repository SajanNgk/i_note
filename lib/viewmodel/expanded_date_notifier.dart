import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpandedDatesNotifier extends StateNotifier<Set<String>> {
  ExpandedDatesNotifier() : super({});

  void toggleExpanded(String date) {
    if (state.contains(date)) {
      state = {...state}..remove(date);
    } else {
      state = {...state}..add(date);
    }
  }
}