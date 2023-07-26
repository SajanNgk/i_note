import 'package:flutter/cupertino.dart';

import 'package:i_note/utils/widgets/add_note_widget.dart';

class AddNoteScreen extends StatelessWidget {
  const AddNoteScreen({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
   
    return CupertinoPageScaffold(
      navigationBar:  CupertinoNavigationBar(
      
        border: null,
        middle: const Text('Add Note'),
      ),
      child: SafeArea(
        child: AddNoteForm(),
      ),
    );
  }
}
