import 'package:hive_flutter/hive_flutter.dart';
import '../model/study_note.dart';

class NotesHiveService {
  final String boxName = 'study_notes_box';

  Box<StudyNote> get _box => Hive.box<StudyNote>(boxName);

  Future<void> addNote(StudyNote note) async {
    await _box.put(note.id, note);
  }

  Future<void> updateNote(StudyNote note) async {
    await _box.put(note.id, note);
  }

  Future<void> deleteNote(String id) async {
    await _box.delete(id);
  }

  List<StudyNote> getAllNotes() {
    return _box.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }
}
