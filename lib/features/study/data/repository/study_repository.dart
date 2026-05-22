import 'package:airman_toga/features/study/data/model/study_subject.dart';
import 'package:airman_toga/features/study/data/service/study_service.dart';

class StudyRepository {

  final StudyService studyService;

  StudyRepository({
    required this.studyService,
  });

  Future<List<StudySubject>> fetchSubjects() async {

    return await studyService.fetchSubjects();
  }
}
