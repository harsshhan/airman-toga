import 'package:airman_toga/core/mock_data/study_mock_data.dart';
import 'package:airman_toga/features/study/data/model/study_subject.dart';

class StudyService {

  Future<List<StudySubject>> fetchSubjects() async {

    await Future.delayed(
      const Duration(milliseconds: 600),
    );

    return (StudyMockData.subjects as List)
        .map((e) => StudySubject.fromJson(e))
        .toList();
  }
}
