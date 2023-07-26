import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_note/model/note_model.dart';
import 'package:i_note/utils/common/textstyles.dart';
import 'package:i_note/utils/providers/date_pr2ovider.dart';

import 'package:i_note/utils/providers/providers.dart';
import 'package:i_note/utils/widgets/list_of_note.dart';
import 'package:intl/intl.dart';

class ListContainerWidget extends ConsumerWidget {
  const ListContainerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var notes = ref.watch(notesProvider);
    notes.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    // Group notes by date
    Map<String, List<Note>> groupedNotes = {};
    for (var note in notes) {
      String formattedDate = DateFormat('MMMM dd, yyyy').format(note.createdAt);
      if (!groupedNotes.containsKey(formattedDate)) {
        groupedNotes[formattedDate] = [];
      }
      groupedNotes[formattedDate]!.add(note);
    }

    final expandedDates = ref.watch(expandedDatesProvider);

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: CustomScrollView(
        slivers: [
          for (var date in groupedNotes.keys)
            CupertinoSliverNavigationBar(
              largeTitle: Row(
                children: [
                  Text(
                    date == DateFormat('MMMM dd, yyyy').format(DateTime.now())
                        ? 'Today'
                        : date,
                    style: CustomTextStyles.h3,
                  ),
                  const Spacer(),
                  CupertinoButton(
                    onPressed: () {
                      ref
                          .read(expandedDatesProvider.notifier)
                          .toggleExpanded(date);
                    },
                    child: Text(
                      expandedDates.contains(date) ? "View less" : "View all",
                      style: CustomTextStyles.bodyRegular.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                var date = groupedNotes.keys.elementAt(index);
                var notesForDate = groupedNotes[date]!;

                final isExpanded = expandedDates.contains(date);

                return Column(
                  children: [
                    for (var note
                        in isExpanded ? notesForDate : notesForDate.take(2))
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomListItemWidget(
                          note: note,
                          onDelete: () {
                            ref.read(notesProvider.notifier).delete(note.id);
                          },
                        ),
                      ),
                  ],
                );
              },
              childCount: groupedNotes.length,
            ),
          ),
        ],
      ),
    );
  }
}
