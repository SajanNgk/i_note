import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_note/utils/common/colors.dart';
import 'package:i_note/utils/common/textstyles.dart';
import 'package:i_note/utils/widgets/custom_nav.dart';
import 'package:i_note/utils/widgets/list_container.dart';
import 'package:i_note/view/add_note.dart';

class Homepage extends ConsumerWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return CupertinoPageScaffold(
      child: Stack(
        children: [
          Container(
            height: h,
            width: w,
            child: Column(
              children: [
                CustomCupertinoNavBar(
                  middle: const Text(
                    "Apple Notes",
                    style: CustomTextStyles.h2,
                  ),
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(CupertinoIcons.bars),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(CupertinoIcons.search),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(CupertinoIcons.ellipsis_vertical),
                    ),
                  ],
                ),
                const Expanded(
                  child: ListContainerWidget(),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColor.kgrey, AppColor.kblack],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.kgrey.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const AddNoteScreen(),
                    ),
                  );
                },
                child: const Icon(
                  CupertinoIcons.add,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
