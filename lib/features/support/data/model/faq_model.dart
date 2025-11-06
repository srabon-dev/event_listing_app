class FaqModel {
  final bool? success;
  final String? message;
  final List<FaqItem>? data;

  FaqModel({
    this.success,
    this.message,
    this.data,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<FaqItem>.from(json["data"]!.map((x) => FaqItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class FaqItem {
  final String? id;
  final String? question;
  final String? answer;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final num? v;
  final String? datumId;

  FaqItem({
    this.id,
    this.question,
    this.answer,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.datumId,
  });

  factory FaqItem.fromJson(Map<String, dynamic> json) => FaqItem(
    id: json["_id"],
    question: json["question"],
    answer: json["answer"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    datumId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "question": question,
    "answer": answer,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "id": datumId,
  };
}
