import 'logbook_entry.dart';

class LogbookSummary {
  final double totalHours;
  final double dualHours;
  final double soloHours;
  final String lastFlight;

  final List<LogbookEntry>
      recentEntries;

  const LogbookSummary({
    required this.totalHours,
    required this.dualHours,
    required this.soloHours,
    required this.lastFlight,
    required this.recentEntries,
  });

  factory LogbookSummary.fromJson(
      Map<String, dynamic> json) {
    return LogbookSummary(
      totalHours:
          (json["total_hours"] ?? 0)
              .toDouble(),

      dualHours:
          (json["dual_hours"] ?? 0)
              .toDouble(),

      soloHours:
          (json["solo_hours"] ?? 0)
              .toDouble(),

      lastFlight:
          json["last_flight"] ?? "",

      recentEntries:
          (json["recent_entries"]
                  as List)
              .map(
                (e) =>
                    LogbookEntry
                        .fromJson(e),
              )
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "total_hours":
          totalHours,

      "dual_hours":
          dualHours,

      "solo_hours":
          soloHours,

      "last_flight":
          lastFlight,

      "recent_entries":
          recentEntries
              .map(
                (e) =>
                    e.toJson(),
              )
              .toList(),
    };
  }
}