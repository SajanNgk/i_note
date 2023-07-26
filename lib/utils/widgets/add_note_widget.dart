import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_note/model/note_model.dart';
import 'package:i_note/utils/providers/providers.dart';
import 'package:uuid/uuid.dart';

class AddNoteForm extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  Note? initialNote;

  AddNoteForm({super.key}); // To hold the initial data for editing

  void edit(Note note) {
    initialNote = note;
    _titleController.text = note.title ?? '';
    _bodyController.text = note.body ?? '';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: Text('Note Details')),
            const SizedBox(height: 16),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _bodyController,
              decoration: InputDecoration(labelText: 'Enter your words'),
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a body';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _saveNote(ref);
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveNote(WidgetRef ref) {
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

   
  }
}
