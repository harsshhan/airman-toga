import 'package:hive/hive.dart';

part 'sync_status.g.dart';

@HiveType(typeId: 1)
enum SyncStatus {
  @HiveField(0)
  pending,
  
  @HiveField(1)
  syncing,
  
  @HiveField(2)
  synced,
  
  @HiveField(3)
  failed,
}
