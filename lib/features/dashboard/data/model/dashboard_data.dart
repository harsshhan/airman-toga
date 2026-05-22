import 'logbook_preview.dart';
import 'upcoming_flight.dart';

class DashboardData {

  final String cadetName;
  final String course;
  final String trainingStage;
  final String assignedFto;
  final String assignedFtoDetails;
  final String assignedInstructor;
  final String assignedInstructorDetails;

  final int overallStudyProgress;
  final int lessonsCompleted;
  final int totalLessons;
  final String nextStudyTopic;

  final UpcomingFlight upcomingFlight;

  final LogbookSummary logbook;

  const DashboardData({

    required this.cadetName,
    required this.course,
    required this.trainingStage,
    required this.assignedFto,
    required this.assignedFtoDetails,
    required this.assignedInstructor,
    required this.assignedInstructorDetails,
    required this.overallStudyProgress,
    required this.lessonsCompleted,
    required this.totalLessons,
    required this.nextStudyTopic,
    required this.upcomingFlight,
    required this.logbook,

  });

  factory DashboardData.fromJson(
      Map<String,dynamic> json){

    return DashboardData(

      cadetName:
      json["cadet_name"] ?? "",

      course:
      json["course"] ?? "",

      trainingStage:
      json["training_stage"] ?? "",

      assignedFto:
      json["assigned_fto"] ?? "",

      assignedFtoDetails:
      json["assigned_fto_details"] ?? "",

      assignedInstructor:
      json["assigned_instructor"] ?? "",

      assignedInstructorDetails:
      json["assigned_instructor_details"] ?? "",

      overallStudyProgress:
      json["overall_study_progress"] ?? 0,

      lessonsCompleted:
      json["lessons_completed"] ?? 0,

      totalLessons:
      json["total_lessons"] ?? 0,

      nextStudyTopic:
      json["next_study_topic"] ?? "",

      upcomingFlight:
      UpcomingFlight.fromJson(
          json["upcoming_flight"]),

      logbook:
      LogbookSummary.fromJson(
          json["logbook"]),
    );
  }

  Map<String,dynamic> toJson(){

    return {

      "cadet_name": cadetName,
      "course": course,
      "training_stage": trainingStage,
      "assigned_fto": assignedFto,
      "assigned_fto_details": assignedFtoDetails,
      "assigned_instructor": assignedInstructor,
      "assigned_instructor_details": assignedInstructorDetails,
      "overall_study_progress":
      overallStudyProgress,

      "lessons_completed": lessonsCompleted,
      "total_lessons": totalLessons,
      "next_study_topic": nextStudyTopic,

      "upcoming_flight":
      upcomingFlight.toJson(),

      "logbook":
      logbook.toJson(),

    };
  }
}
