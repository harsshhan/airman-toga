class UpcomingFlight {

  final String aircraft;
  final String date;
  final String time;
  final String lesson;

  const UpcomingFlight({
    required this.aircraft,
    required this.date,
    required this.time,
    required this.lesson,
  });

  factory UpcomingFlight.fromJson(
      Map<String,dynamic> json){

    return UpcomingFlight(
      aircraft: json["aircraft"] ?? "",
      date: json["date"] ?? "",
      time: json["time"] ?? "",
      lesson: json["lesson"] ?? "",
    );
  }

  Map<String,dynamic> toJson(){
    return {

      "aircraft": aircraft,
      "date": date,
      "time": time,
      "lesson": lesson,

    };
  }
}