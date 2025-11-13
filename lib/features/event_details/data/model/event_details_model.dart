class EventDetailsModel {
  final bool? success;
  final String? message;
  final EventDetailsData? data;

  EventDetailsModel({
    this.success,
    this.message,
    this.data,
  });

  factory EventDetailsModel.fromJson(Map<String, dynamic> json) => EventDetailsModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : EventDetailsData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class EventDetailsData {
  final String? id;
  final EventDetailsOrganizer? organizer;
  final String? name;
  final String? shortDescription;
  final EventDetailsEventType? sport;
  final EventDetailsEventType? eventType;
  final DateTime? registrationStartDate;
  final DateTime? registrationEndDateTime;
  final DateTime? eventStartDateTime;
  final DateTime? eventEndDateTime;
  final num? minAge;
  final num? maxAge;
  final String? skillLevel;
  final num? availableSlot;
  final String? zipCode;
  final String? address;
  final EventDetailsLocation? location;
  final String? city;
  final String? websiteLink;
  final num? registrationFee;
  final String? description;
  final String? image;
  final String? status;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final num? v;
  final num? averageRating;

  EventDetailsData({
    this.id,
    this.organizer,
    this.name,
    this.shortDescription,
    this.sport,
    this.eventType,
    this.registrationStartDate,
    this.registrationEndDateTime,
    this.eventStartDateTime,
    this.eventEndDateTime,
    this.minAge,
    this.maxAge,
    this.skillLevel,
    this.availableSlot,
    this.zipCode,
    this.address,
    this.location,
    this.city,
    this.websiteLink,
    this.registrationFee,
    this.description,
    this.image,
    this.status,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.averageRating,
  });

  factory EventDetailsData.fromJson(Map<String, dynamic> json) => EventDetailsData(
    id: json["_id"],
    organizer: json["organizer"] == null ? null : EventDetailsOrganizer.fromJson(json["organizer"]),
    name: json["name"],
    shortDescription: json["shortDescription"],
    sport: json["sport"] == null ? null : EventDetailsEventType.fromJson(json["sport"]),
    eventType: json["eventType"] == null ? null : EventDetailsEventType.fromJson(json["eventType"]),
    registrationStartDate: json["registrationStartDate"] == null ? null : DateTime.parse(json["registrationStartDate"]),
    registrationEndDateTime: json["registrationEndDateTime"] == null ? null : DateTime.parse(json["registrationEndDateTime"]),
    eventStartDateTime: json["eventStartDateTime"] == null ? null : DateTime.parse(json["eventStartDateTime"]),
    eventEndDateTime: json["eventEndDateTime"] == null ? null : DateTime.parse(json["eventEndDateTime"]),
    minAge: json["minAge"],
    maxAge: json["maxAge"],
    skillLevel: json["skillLevel"],
    availableSlot: json["availableSlot"],
    zipCode: json["zipCode"],
    address: json["address"],
    location: json["location"] == null ? null : EventDetailsLocation.fromJson(json["location"]),
    city: json["city"],
    websiteLink: json["websiteLink"],
    registrationFee: json["registrationFee"],
    description: json["description"],
    image: json["image"],
    status: json["status"],
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    averageRating: json["averageRating"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "organizer": organizer,
    "name": name,
    "shortDescription": shortDescription,
    "sport": sport?.toJson(),
    "eventType": eventType?.toJson(),
    "registrationStartDate": registrationStartDate?.toIso8601String(),
    "registrationEndDateTime": registrationEndDateTime?.toIso8601String(),
    "eventStartDateTime": eventStartDateTime?.toIso8601String(),
    "eventEndDateTime": eventEndDateTime?.toIso8601String(),
    "minAge": minAge,
    "maxAge": maxAge,
    "skillLevel": skillLevel,
    "availableSlot": availableSlot,
    "zipCode": zipCode,
    "address": address,
    "location": location?.toJson(),
    "city": city,
    "websiteLink": websiteLink,
    "registrationFee": registrationFee,
    "description": description,
    "images": image,
    "isDeleted": isDeleted,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "averageRating": averageRating,
  };
}

class EventDetailsEventType {
  final String? id;
  final String? name;
  final String? type;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final num? v;
  final String? categoryImage;

  EventDetailsEventType({
    this.id,
    this.name,
    this.type,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.categoryImage,
  });

  factory EventDetailsEventType.fromJson(Map<String, dynamic> json) => EventDetailsEventType(
    id: json["_id"],
    name: json["name"],
    type: json["type"],
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    categoryImage: json["category_image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "type": type,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "category_image": categoryImage,
  };
}

class EventDetailsLocation {
  final String? type;
  final List<double>? coordinates;

  EventDetailsLocation({
    this.type,
    this.coordinates,
  });

  factory EventDetailsLocation.fromJson(Map<String, dynamic> json) => EventDetailsLocation(
    type: json["type"],
    coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
  };
}

class EventDetailsOrganizer {
  final String? id;
  final String? user;
  final String? name;
  final String? businessName;
  final String? phone;
  final String? email;
  final String? address;
  final String? profileImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  EventDetailsOrganizer({
    this.id,
    this.user,
    this.name,
    this.businessName,
    this.phone,
    this.email,
    this.address,
    this.profileImage,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory EventDetailsOrganizer.fromJson(Map<String, dynamic> json) => EventDetailsOrganizer(
    id: json["_id"],
    user: json["user"],
    name: json["name"],
    businessName: json["businessName"],
    phone: json["phone"],
    email: json["email"],
    address: json["address"],
    profileImage: json["profile_image"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user,
    "name": name,
    "businessName": businessName,
    "phone": phone,
    "email": email,
    "address": address,
    "profile_image": profileImage,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
