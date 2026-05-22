import 'package:airman_toga/features/study/data/model/study_subject.dart';
import 'package:airman_toga/features/study/data/repository/study_repository.dart';
import 'package:flutter/material.dart';

class StudyProvider extends ChangeNotifier {

  final StudyRepository repository;

  StudyProvider({
    required this.repository,
  });

  bool isLoading = false;

  List<StudySubject> subjects = [];

  String? error;

  Future<void> fetchSubjects() async {

    try {

      isLoading = true;
      notifyListeners();

      subjects = await repository.fetchSubjects();

    } catch (e) {

      error = 'Failed to load subjects';
    }

    isLoading = false;
    notifyListeners();
  }
}
