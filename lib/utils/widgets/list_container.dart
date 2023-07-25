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

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var note in notes)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      DateFormat('MMMM dd, yyyy').format(note
                          .createdAt), // Display the createdAt date of the notes
                      style: CustomTextStyles.h3,
                    ),
                    const Spacer(),
                    CupertinoButton(
                      onPressed: () {},
                      child: Text(
                        'View All',
                        style: CustomTextStyles.bodyRegular,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                CustomListItemWidget(
                  note: note,
                  onDelete: () {
                    ref
                        .read(noteStateNotifierProvider.notifier)
                        .delete(note.id);
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}
