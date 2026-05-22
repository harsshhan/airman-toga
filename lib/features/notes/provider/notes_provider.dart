import 'dart:async';
import 'package:flutter/material.dart';

import '../data/model/study_note.dart';
import '../data/model/sync_status.dart';
import '../data/repository/notes_repository.dart';
import '../../../../core/mock_data/notes_mock_data.dart';
import 'package:intl/intl.dart';

class NotesProvider extends ChangeNotifier {
  final NotesRepository repository;

  NotesProvider({required this.repository});

  List<StudyNote> notes = [];
  bool isSyncing = false;
  Timer? _debounce;

  void loadNotes() {
    notes = repository.getNotes();
    if (notes.isEmpty) {
      _seedMockData();
    } else {
      notifyListeners();
    }
  }

  void _seedMockData() {
    for (final mock in NotesMockData.notes) {
      SyncStatus status = SyncStatus.pending;
      if (mock['sync_status'] == 'Synced') status = SyncStatus.synced;
      if (mock['sync_status'] == 'Failed') status = SyncStatus.failed;

      final note = StudyNote(
        id: mock['id']!,
        subject: mock['subject']!,
        content: mock['content']!,
        createdAt: DateFormat("dd MMM yyyy").parse(mock['created_at']!),
        syncStatus: status,
      );
      
      // Save it bypassing debounce
      repository.saveDraft(note);
    }
    // Reload after seeding
    notes = repository.getNotes();
    notifyListeners();
  }

  void saveDraft(StudyNote note) {
    // Auto-save typing with debounce
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      await repository.saveDraft(note);
      loadNotes(); // Refresh list to reflect pending status
    });
  }

  Future<void> saveAndSyncNote(StudyNote note) async {
    // Immediate save and sync, no debounce
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    // Optimistically add to list or update if it exists as syncing
    final syncingNote = note.copyWith(syncStatus: SyncStatus.syncing);
    final index = notes.indexWhere((n) => n.id == note.id);
    if (index >= 0) {
      notes[index] = syncingNote;
    } else {
      notes.insert(0, syncingNote);
    }
    notifyListeners();

    await repository.saveAndSyncNote(note);
    loadNotes(); // Refresh after sync attempts
  }

  Future<void> deleteNote(String id) async {
    await repository.deleteNote(id);
    loadNotes();
  }

  Future<void> syncAllPending() async {
    final unsynced = notes.where((n) => 
        n.syncStatus == SyncStatus.pending || 
        n.syncStatus == SyncStatus.failed
    ).toList();

    if (unsynced.isEmpty) return;

    isSyncing = true;
    notifyListeners();

    for (var i = 0; i < unsynced.length; i++) {
      final note = unsynced[i];
      // Optimistically show syncing in UI
      final index = notes.indexWhere((n) => n.id == note.id);
      if (index >= 0) {
        notes[index] = note.copyWith(syncStatus: SyncStatus.syncing);
        notifyListeners();
      }
      await repository.saveAndSyncNote(note);
    }
    
    isSyncing = false;
    loadNotes();
  }
}
