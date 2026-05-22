import 'package:airman_toga/features/logbook/data/model/logbook_summary.dart';
import 'package:airman_toga/features/logbook/data/service/logbook_service.dart';

class LogbookRepository {
  final LogbookService logbookService;

  LogbookRepository({required this.logbookService});

  Future<LogbookSummary> fetchLogbook() async {
    return await logbookService.fetchLogbook();
  }
}
