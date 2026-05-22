
class LogbookSummary {

  final double totalHours;
  final double soloHours;
  final String lastFlight;

  const LogbookSummary({
    required this.totalHours,
    required this.soloHours,
    required this.lastFlight,
  });

  factory LogbookSummary.fromJson(
      Map<String,dynamic> json){

    return LogbookSummary(

      totalHours:
      (json["total_hours"] ?? 0)
          .toDouble(),

      soloHours:
      (json["solo_hours"] ?? 0)
          .toDouble(),

      lastFlight:
      json["last_flight"] ?? "",

    );
  }

  Map<String,dynamic> toJson(){

    return {

      "total_hours": totalHours,
      "solo_hours": soloHours,
      "last_flight": lastFlight,

    };
  }
}