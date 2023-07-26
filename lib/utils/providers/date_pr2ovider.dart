

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_note/viewmodel/expanded_date_notifier.dart';

final expandedDatesProvider = StateNotifierProvider<ExpandedDatesNotifier, Set<String>>((ref) => ExpandedDatesNotifier());

