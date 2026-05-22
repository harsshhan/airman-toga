class Chapter {

  final String chapter;
  final int lessonCount;
  final bool completed;

  const Chapter({
    required this.chapter,
    required this.lessonCount,
    required this.completed,
  });

  factory Chapter.fromJson(
      Map<String,dynamic> json){

    return Chapter(
      chapter:
          json["chapter"] ?? "",

      lessonCount:
          json["lesson_count"] ?? 0,

      completed:
          json["completed"] ?? false,
    );
  }

  Map<String,dynamic> toJson(){

    return {

      "chapter": chapter,
      "lesson_count": lessonCount,
      "completed": completed,

    };
  }
}