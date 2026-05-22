import 'package:airman_toga/features/logbook/data/model/logbook_summary.dart';
import 'package:airman_toga/features/logbook/data/repository/logbook_repository.dart';
import 'package:flutter/material.dart';

class LogbookProvider extends ChangeNotifier {
  final LogbookRepository repository;

  LogbookProvider({required this.repository});

  bool isLoading = false;
  LogbookSummary? summary;
  String? error;

  Future<void> fetchLogbook() async {
    try {
      isLoading = true;
      notifyListeners();

      summary = await repository.fetchLogbook();
    } catch (e) {
      error = 'Failed to load logbook';
    }

    isLoading = false;
    notifyListeners();
  }
}
