import '../service/notes_hive_service.dart';
import '../model/study_note.dart';
import '../model/sync_status.dart';
import '../service/notes_api_service.dart';

class NotesRepository {
  final NotesHiveService localService;
  final NotesApiService remoteService;

  NotesRepository({
    required this.localService,
    required this.remoteService,
  });

  List<StudyNote> getNotes() {
    return localService.getAllNotes();
  }

  Future<void> saveDraft(StudyNote note) async {
    final updatedNote = note.copyWith(syncStatus: SyncStatus.pending);
    await localService.updateNote(updatedNote);
  }

  Future<void> saveAndSyncNote(StudyNote note) async {
    var currentNote = note.copyWith(syncStatus: SyncStatus.pending);
    await localService.updateNote(currentNote);

    currentNote = currentNote.copyWith(syncStatus: SyncStatus.syncing);
    await localService.updateNote(currentNote);

    try {
      final success = await remoteService.syncNote(currentNote);
      if (success) {
        currentNote = currentNote.copyWith(syncStatus: SyncStatus.synced);
      } else {
        currentNote = currentNote.copyWith(
          syncStatus: SyncStatus.failed,
          retryCount: currentNote.retryCount + 1,
        );
      }
    } catch (e) {
      currentNote = currentNote.copyWith(
        syncStatus: SyncStatus.failed,
        retryCount: currentNote.retryCount + 1,
      );
    }

    await localService.updateNote(currentNote);
  }

  Future<void> deleteNote(String id) async {
    await localService.deleteNote(id);
  }
}
