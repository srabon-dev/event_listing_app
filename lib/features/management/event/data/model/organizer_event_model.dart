class OrganizerEventModel {
  final bool? success;
  final String? message;
  final OrganizerData? data;

  OrganizerEventModel({
    this.success,
    this.message,
    this.data,
  });

  factory OrganizerEventModel.fromJson(Map<String, dynamic> json) => OrganizerEventModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : OrganizerData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class OrganizerData {
  final List<OrganizerEventItem>? result;

  OrganizerData({
    this.result,
  });

  factory OrganizerData.fromJson(Map<String, dynamic> json) => OrganizerData(
    result: json["result"] == null ? [] : List<OrganizerEventItem>.from(json["result"]!.map((x) => OrganizerEventItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class OrganizerEventItem {
  final String? id;
  // final String? organizer;
  final String? name;
  final String? shortDescription;
  final OrganizerEventType? sport;
  final OrganizerEventType? eventType;
  final DateTime? registrationStartDateTime;
  final DateTime? registrationEndDateTime;
  final DateTime? eventStartDateTime;
  final DateTime? eventEndDateTime;
  final num? minAge;
  final num? maxAge;
  final String? skillLevel;
  final num? availableSlot;
  final String? zipCode;
  final String? address;
  final OrganizerLocation? location;
  final String? city;
  final String? websiteLink;
  final num? registrationFee;
  final String? description;
  final String? image;
  final bool? isDeleted;
  final String? status;
  final num? averageRating;

  OrganizerEventItem({
    this.id,
    // this.organizer,
    this.name,
    this.shortDescription,
    this.sport,
    this.eventType,
    this.registrationStartDateTime,
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
    this.isDeleted,
    this.status,
    this.averageRating,
  });

  factory OrganizerEventItem.fromJson(Map<String, dynamic> json) => OrganizerEventItem(
    id: json["_id"],
    // organizer: json["organizer"],
    name: json["name"],
    shortDescription: json["shortDescription"],
    sport: json["sport"] == null ? null : OrganizerEventType.fromJson(json["sport"]),
    eventType: json["eventType"] == null ? null : OrganizerEventType.fromJson(json["eventType"]),
    registrationStartDateTime: json["registrationStartDateTime"] == null ? null : DateTime.parse(json["registrationStartDateTime"]),
    registrationEndDateTime: json["registrationEndDateTime"] == null ? null : DateTime.parse(json["registrationEndDateTime"]),
    eventStartDateTime: json["eventStartDateTime"] == null ? null : DateTime.parse(json["eventStartDateTime"]),
    eventEndDateTime: json["eventEndDateTime"] == null ? null : DateTime.parse(json["eventEndDateTime"]),
    minAge: json["minAge"],
    maxAge: json["maxAge"],
    skillLevel: json["skillLevel"],
    availableSlot: json["availableSlot"],
    zipCode: json["zipCode"],
    address: json["address"],
    location: json["location"] == null ? null : OrganizerLocation.fromJson(json["location"]),
    city: json["city"],
    websiteLink: json["websiteLink"],
    registrationFee: json["registrationFee"],
    description: json["description"],
    image: json["image"],
    isDeleted: json["isDeleted"],
    status: json["status"],
    averageRating: json["averageRating"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    // "organizer": organizer,
    "name": name,
    "shortDescription": shortDescription,
    "sport": sport?.toJson(),
    "eventType": eventType?.toJson(),
    "registrationStartDateTime": registrationStartDateTime?.toLocal().toIso8601String(),
    "registrationEndDateTime": registrationEndDateTime?.toLocal().toIso8601String(),
    "eventStartDateTime": eventStartDateTime?.toLocal().toIso8601String(),
    "eventEndDateTime": eventEndDateTime?.toLocal().toIso8601String(),
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
    "image": image,
    "isDeleted": isDeleted,
    "status": status,
    "averageRating": averageRating,
  };
}

class OrganizerEventType {
  final String? id;
  final String? name;
  final String? type;
  final bool? isDeleted;
  final String? categoryImage;

  OrganizerEventType({
    this.id,
    this.name,
    this.type,
    this.isDeleted,
    this.categoryImage,
  });

  factory OrganizerEventType.fromJson(Map<String, dynamic> json) => OrganizerEventType(
    id: json["_id"],
    name: json["name"],
    type: json["type"],
    isDeleted: json["isDeleted"],
    categoryImage: json["category_image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "type": type,
    "isDeleted": isDeleted,
    "category_image": categoryImage,
  };
}

class OrganizerLocation {
  final String? type;
  final List<double>? coordinates;

  OrganizerLocation({
    this.type,
    this.coordinates,
  });

  factory OrganizerLocation.fromJson(Map<String, dynamic> json) => OrganizerLocation(
    type: json["type"],
    coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
  };
}
