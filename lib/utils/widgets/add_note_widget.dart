import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_note/model/note_model.dart';
import 'package:i_note/utils/common/textstyles.dart';
import 'package:i_note/utils/providers/providers.dart';
import 'package:uuid/uuid.dart';

class AddNoteForm extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final Note?
      initialNote; // Add a Note parameter to hold the initial data for update

  AddNoteForm({Key? key, this.initialNote}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // If initialNote is not null, set the initial values of the text fields
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
              child: CupertinoTextFormFieldRow(
                controller: _titleController,
                placeholder: 'Title',
                style: CustomTextStyles.h3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 8),
            Container(
              color: CupertinoColors.white,
              child: CupertinoTextFormFieldRow(
                controller: _bodyController,
                placeholder: 'Enter your words',
                style: CustomTextStyles.bodyRegular,
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a body';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16),
            CupertinoButton.filled(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _saveNote(context, ref);
                }
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
            id: const Uuid().v1(), // Generate a unique id for new notes
            title: title,
            body: body,
            createdAt: DateTime.now(),
          );

    if (initialNote != null) {
      // If initialNote is not null, it means you are updating an existing note
      ref.read(notesProvider.notifier).update(note);
    } else {
      // If initialNote is null, it means you are adding a new note
      ref.read(notesProvider.notifier).add(note);
    }

    // Clear form fields after adding/updating the note
    _titleController.clear();
    _bodyController.clear();

    // Show success dialog after adding/updating the note
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
