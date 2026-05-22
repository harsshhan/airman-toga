import '../model/study_note.dart';

class NotesApiService {
  Future<bool> syncNote(StudyNote note) async {
    await Future.delayed(const Duration(seconds: 2));
    
    if (note.retryCount == 0) {
      return false;
    }
    return true;
  }
}
