class LogbookEntry {
  final String date;
  final String aircraft;
  final String route;
  final double duration;
  final String lesson;

  const LogbookEntry({
    required this.date,
    required this.aircraft,
    required this.route,
    required this.duration,
    required this.lesson,
  });

  factory LogbookEntry.fromJson(
      Map<String, dynamic> json) {
    return LogbookEntry(
      date: json["date"] ?? "",

      aircraft:
          json["aircraft"] ?? "",

      route:
          json["route"] ?? "",

      duration:
          (json["duration"] ?? 0)
              .toDouble(),

      lesson:
          json["lesson"] ?? "",

    );
  }

  Map<String, dynamic> toJson() {
    return {
      "date": date,

      "aircraft": aircraft,

      "route": route,

      "duration": duration,

      "lesson": lesson,
    };
  }
}