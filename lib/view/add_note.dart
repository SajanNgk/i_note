import 'package:flutter/cupertino.dart';
import 'package:i_note/model/note_model.dart';
import 'package:i_note/utils/common/textstyles.dart';
import 'package:i_note/utils/widgets/add_note_widget.dart';

class AddNoteScreen extends StatelessWidget {
  final Note? initialNote;

  const AddNoteScreen({Key? key, this.initialNote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        
        border: null,
        middle:   Text('Add Note',style : CustomTextStyles.h2),
      ),
      child: SafeArea(
        child: AddNoteForm(initialNote: initialNote), 
      ),
    );
  }
}
