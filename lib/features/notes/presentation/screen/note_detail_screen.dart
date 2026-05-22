import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/model/study_note.dart';
import '../../provider/notes_provider.dart';

class NoteDetailScreen extends StatefulWidget {
  final StudyNote? note; 

  const NoteDetailScreen({super.key, this.note});

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late TextEditingController _subjectController;
  late TextEditingController _contentController;
  late String _noteId;
  late DateTime _createdAt;

  @override
  void initState() {
    super.initState();
    _noteId = widget.note?.id ?? const Uuid().v4();
    _createdAt = widget.note?.createdAt ?? DateTime.now();
    _subjectController = TextEditingController(text: widget.note?.subject ?? '');
    _contentController = TextEditingController(text: widget.note?.content ?? '');
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveDraft() {
    if (_subjectController.text.trim().isEmpty &&
        _contentController.text.trim().isEmpty) {
      return;
    }

    final note = StudyNote(
      id: _noteId,
      subject: _subjectController.text.trim(),
      content: _contentController.text.trim(),
      createdAt: _createdAt,
    );

    context.read<NotesProvider>().saveDraft(note);
  }

  void _syncNote() {
    if (_subjectController.text.trim().isEmpty &&
        _contentController.text.trim().isEmpty) {
      Navigator.pop(context);
      return;
    }

    final note = StudyNote(
      id: _noteId,
      subject: _subjectController.text.trim(),
      content: _contentController.text.trim(),
      createdAt: _createdAt,
    );

    context.read<NotesProvider>().saveAndSyncNote(note);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitebackground,
      appBar: AppBar(
        backgroundColor: AppColors.whitebackground,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: Text(
          widget.note == null ? 'New Note' : 'Edit Note',
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (widget.note != null)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: AppColors.error),
              onPressed: () {
                context.read<NotesProvider>().deleteNote(_noteId);
                Navigator.pop(context);
              },
            ),
          TextButton(
            onPressed: _syncNote,
            child: const Text(
              'Save',
              style: TextStyle(
                color: AppColors.secondary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _subjectController,
              onChanged: (_) => _saveDraft(),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              decoration: const InputDecoration(
                hintText: 'Subject / Title',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: AppColors.textHint,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(),
            Expanded(
              child: TextField(
                controller: _contentController,
                onChanged: (_) => _saveDraft(),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textPrimary,
                  height: 1.5,
                ),
                decoration: const InputDecoration(
                  hintText: 'Start typing your study notes here...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: AppColors.textHint,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
