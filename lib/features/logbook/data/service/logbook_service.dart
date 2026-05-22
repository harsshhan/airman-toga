import 'package:airman_toga/core/mock_data/logbook_mock_data.dart';
import 'package:airman_toga/features/logbook/data/model/logbook_summary.dart';

class LogbookService {
  Future<LogbookSummary> fetchLogbook() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return LogbookSummary.fromJson(LogbookMockData.summary);
  }
}
