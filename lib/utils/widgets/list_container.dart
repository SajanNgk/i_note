import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_note/model/note_model.dart';
import 'package:i_note/utils/common/textstyles.dart';
import 'package:i_note/utils/providers/providers.dart';
import 'package:i_note/utils/widgets/list_of_note.dart';
import 'package:intl/intl.dart';

class ListContainerWidget extends ConsumerWidget {
  const ListContainerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var notes = ref.watch(noteStateNotifierProvider);
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

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: CustomScrollView(
        slivers: [
          for (var date in groupedNotes.keys)
            CupertinoSliverNavigationBar(
              largeTitle: Text(date, style: CustomTextStyles.h3),
              trailing: CupertinoButton(
                onPressed: () {},
                child: Text(
                  'View All',
                  style: CustomTextStyles.bodyRegular.copyWith(
                    color: CupertinoColors.systemBlue,
                  ),
                ),
              ),
            ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                var date = groupedNotes.keys.elementAt(index);
                var notesForDate = groupedNotes[date]!;
                return Column(
                  children: [
                    for (var note in notesForDate)
                      CustomListItemWidget(
                        note: note,
                        onDelete: () {
                          ref
                              .read(noteStateNotifierProvider.notifier)
                              .delete(note.id);
                        },
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
