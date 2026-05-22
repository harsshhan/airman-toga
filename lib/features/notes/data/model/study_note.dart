import 'package:hive/hive.dart';
import 'sync_status.dart';

part 'study_note.g.dart';

@HiveType(typeId: 0)
class StudyNote {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String subject;

  @HiveField(2)
  final String content;

  @HiveField(3)
  final DateTime createdAt;

  @HiveField(4)
  final SyncStatus syncStatus;

  @HiveField(5, defaultValue: 0)
  final int retryCount;

  StudyNote({
    required this.id,
    required this.subject,
    required this.content,
    required this.createdAt,
    this.syncStatus = SyncStatus.pending,
    this.retryCount = 0,
  });

  StudyNote copyWith({
    String? id,
    String? subject,
    String? content,
    DateTime? createdAt,
    SyncStatus? syncStatus,
    int? retryCount,
  }) {
    return StudyNote(
      id: id ?? this.id,
      subject: subject ?? this.subject,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      syncStatus: syncStatus ?? this.syncStatus,
      retryCount: retryCount ?? this.retryCount,
    );
  }
}
