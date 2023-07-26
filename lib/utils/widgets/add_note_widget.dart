import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'package:i_note/model/note_model.dart';
import 'package:i_note/utils/common/textstyles.dart';
import 'package:i_note/utils/providers/providers.dart';

class AddNoteForm extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final Note?
      initialNote; 
  final int titleCharacterLimit = 50;

  AddNoteForm({Key? key, this.initialNote}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   
    if (initialNote != null) {
      _titleController.text = initialNote!.title ?? '';
      _bodyController.text = initialNote!.body ?? '';
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: Text('Note Details', style: CustomTextStyles.h3)),
            const SizedBox(height: 16),
            Container(
              color: CupertinoColors.white,
              child: CupertinoTextField(
                controller: _titleController,
                placeholder: 'Title',
                style: CustomTextStyles.h2,
                maxLength: titleCharacterLimit,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              color: CupertinoColors.white,
              child: CupertinoTextField(
                controller: _bodyController,
                placeholder: 'Enter your words',
                style: CustomTextStyles.h3,
                maxLines: 5,
              ),
            ),
            const SizedBox(height: 16),
            CupertinoButton.filled(
              onPressed: () {
                _formKey.currentState!.save();
                _saveNote(context, ref);
              },
              child: const Text(
                'Save',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveNote(BuildContext context, WidgetRef ref) {
    final title = _titleController.text;
    final body = _bodyController.text;

    final note = initialNote != null
        ? initialNote!.copyWith(title: title, body: body)
        : Note(
            id: const Uuid().v1(), 
            title: title,
            body: body,
            createdAt: DateTime.now(),
          );

    if (initialNote != null) {
      
      ref.read(notesProvider.notifier).update(note);
    } else {
     
      ref.read(notesProvider.notifier).add(note);
    }

  
    _titleController.clear();
    _bodyController.clear();

  
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Note Added'),
          content: const Text('The note has been added/updated successfully.'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
