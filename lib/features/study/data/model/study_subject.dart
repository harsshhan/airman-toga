import 'chapter.dart';

class StudySubject {

  final String subject;

  final int progress;

  final int lessonsCompleted;

  final int totalLessons;

  final int quizScore;

  final String status;

  final List<Chapter> chapters;

  const StudySubject({

    required this.subject,
    required this.progress,
    required this.lessonsCompleted,
    required this.totalLessons,
    required this.quizScore,
    required this.status,
    required this.chapters,

  });

  factory StudySubject.fromJson(
      Map<String,dynamic> json){

    return StudySubject(

      subject:
          json["subject"] ?? "",

      progress:
          json["progress"] ?? 0,

      lessonsCompleted:
          json["lessons_completed"] ?? 0,

      totalLessons:
          json["total_lessons"] ?? 0,

      quizScore:
          json["quiz_score"] ?? 0,

      status:
          json["status"] ?? "",

      chapters:
      (json["chapters"] as List)

      .map(
        (e)=>Chapter.fromJson(e)
      )

      .toList(),
    );
  }

  Map<String,dynamic> toJson(){

    return {

      "subject":subject,

      "progress":progress,

      "lessons_completed":
      lessonsCompleted,

      "total_lessons":
      totalLessons,

      "quiz_score":
      quizScore,

      "status":status,

      "chapters":

      chapters
          .map(
            (e)=>e.toJson()
          )
          .toList()

    };
  }
}