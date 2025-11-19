class NotificationModel {
  final bool? success;
  final String? message;
  final NotificationData? data;

  NotificationModel({
    this.success,
    this.message,
    this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : NotificationData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class NotificationData {
  final List<NotificationItem>? result;

  NotificationData({
    this.result,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
    result: json["result"] == null ? [] : List<NotificationItem>.from(json["result"]!.map((x) => NotificationItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class NotificationItem {
  final String? id;
  final String? title;
  final String? message;
  final String? receiver;
  final List<dynamic>? deleteBy;
  final List<dynamic>? seenBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  NotificationItem({
    this.id,
    this.title,
    this.message,
    this.receiver,
    this.deleteBy,
    this.seenBy,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) => NotificationItem(
    id: json["_id"],
    title: json["title"],
    message: json["message"],
    receiver: json["receiver"],
    deleteBy: json["deleteBy"] == null ? [] : List<dynamic>.from(json["deleteBy"]!.map((x) => x)),
    seenBy: json["seenBy"] == null ? [] : List<dynamic>.from(json["seenBy"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "message": message,
    "receiver": receiver,
    "deleteBy": deleteBy == null ? [] : List<dynamic>.from(deleteBy!.map((x) => x)),
    "seenBy": seenBy == null ? [] : List<dynamic>.from(seenBy!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
