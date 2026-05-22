class NotificationItem {

  final String id;

  final String title;

  final String message;

  final String type;

  final String time;

  final bool isRead;

  const NotificationItem({

    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.time,
    required this.isRead,

  });

  factory NotificationItem.fromJson(
      Map<String,dynamic> json){

    return NotificationItem(

      id:
      json["id"] ?? "",

      title:
      json["title"] ?? "",

      message:
      json["message"] ?? "",

      type:
      json["type"] ?? "",

      time:
      json["time"] ?? "",

      isRead:
      json["is_read"] ?? false,

    );
  }

  Map<String,dynamic> toJson(){

    return {

      "id":id,

      "title":title,

      "message":message,

      "type":type,

      "time":time,

      "is_read":isRead,

    };
  }
}