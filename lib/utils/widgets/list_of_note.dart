import 'package:flutter/cupertino.dart';
import 'package:i_note/model/note_model.dart';
import 'package:i_note/utils/common/textstyles.dart';
import 'package:intl/intl.dart';

class CustomListItemWidget extends StatelessWidget {
  final Note note;
  final VoidCallback onDelete;

  const CustomListItemWidget({super.key, 
    required this.note,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
     final timeFormat = DateFormat('HH:mm');
    final formattedTime = timeFormat.format(note.createdAt);
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                note.title ?? '',
                style: CustomTextStyles.h3,
              ),
              const SizedBox(height: 4),
              Text(
                note.body ?? '',
                style: CustomTextStyles.bodyRegular,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
               formattedTime,
                style: CustomTextStyles.bodyRegular,
              ),
              const SizedBox(height: 4),
              CupertinoButton(
                onPressed: onDelete,
                padding: EdgeInsets.zero,
                child: const Icon(
                  CupertinoIcons.delete,
                  size: 18,
                  color: CupertinoColors.systemRed,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
