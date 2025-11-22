class ShortlistedModel {
  final bool? success;
  final String? message;
  final ShortlistedData? data;

  ShortlistedModel({
    this.success,
    this.message,
    this.data,
  });

  factory ShortlistedModel.fromJson(Map<String, dynamic> json) => ShortlistedModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : ShortlistedData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class ShortlistedData {
  final List<ShortlistedItem>? result;

  ShortlistedData({
    this.result,
  });

  factory ShortlistedData.fromJson(Map<String, dynamic> json) => ShortlistedData(
    result: json["result"] == null ? [] : List<ShortlistedItem>.from(json["result"]!.map((x) => ShortlistedItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class ShortlistedItem {
  final String? id;
  final ShortlistedEvent? event;

  ShortlistedItem({
    this.id,
    this.event,
  });

  factory ShortlistedItem.fromJson(Map<String, dynamic> json) => ShortlistedItem(
    id: json["_id"],
    event: json["event"] == null ? null : ShortlistedEvent.fromJson(json["event"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "event": event?.toJson(),
  };
}

class ShortlistedEvent {
  final String? id;
  final ShortlistedOrganizer? organizer;
  final String? name;
  final String? shortDescription;
  final String? description;
  final String? image;
  final ShortlistedSport? sport;
  final ShortlistedEventType? eventType;
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
  final ShortlistedLocation? location;
  final String? city;
  final String? websiteLink;
  final num? registrationFee;
  final String? status;
  final num? totalRating;
  final num? avgRating;

  ShortlistedEvent({
    this.id,
    this.organizer,
    this.name,
    this.shortDescription,
    this.description,
    this.image,
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
    this.status,
    this.totalRating,
    this.avgRating,
  });

  factory ShortlistedEvent.fromJson(Map<String, dynamic> json) => ShortlistedEvent(
    id: json["_id"],
    organizer: json["organizer"] == null ? null : ShortlistedOrganizer.fromJson(json["organizer"]),
    name: json["name"],
    shortDescription: json["shortDescription"],
    description: json["description"],
    image: json["image"],
    sport: json["sport"] == null ? null : ShortlistedSport.fromJson(json["sport"]),
    eventType: json["eventType"] == null ? null : ShortlistedEventType.fromJson(json["eventType"]),
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
    location: json["location"] == null ? null : ShortlistedLocation.fromJson(json["location"]),
    city: json["city"],
    websiteLink: json["websiteLink"],
    registrationFee: json["registrationFee"],
    status: json["status"],
    totalRating: json["totalRating"],
    avgRating: json["avgRating"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "organizer": organizer?.toJson(),
    "name": name,
    "shortDescription": shortDescription,
    "description": description,
    "image": image,
    "sport": sport?.toJson(),
    "eventType": eventType?.toJson(),
    "registrationStartDateTime": registrationStartDateTime?.toIso8601String(),
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
    "status": status,
    "totalRating": totalRating,
    "avgRating": avgRating,
  };
}

class ShortlistedEventType {
  final String? id;
  final String? name;

  ShortlistedEventType({
    this.id,
    this.name,
  });

  factory ShortlistedEventType.fromJson(Map<String, dynamic> json) => ShortlistedEventType(
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}

class ShortlistedLocation {
  final String? type;
  final List<double>? coordinates;

  ShortlistedLocation({
    this.type,
    this.coordinates,
  });

  factory ShortlistedLocation.fromJson(Map<String, dynamic> json) => ShortlistedLocation(
    type: json["type"],
    coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
  };
}

class ShortlistedOrganizer {
  final String? id;
  final String? name;
  final String? businessName;
  final String? phone;
  final String? email;

  ShortlistedOrganizer({
    this.id,
    this.name,
    this.businessName,
    this.phone,
    this.email,
  });

  factory ShortlistedOrganizer.fromJson(Map<String, dynamic> json) => ShortlistedOrganizer(
    id: json["_id"],
    name: json["name"],
    businessName: json["businessName"],
    phone: json["phone"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "businessName": businessName,
    "phone": phone,
    "email": email,
  };
}

class ShortlistedSport {
  final String? id;
  final String? name;
  final String? categoryImage;

  ShortlistedSport({
    this.id,
    this.name,
    this.categoryImage,
  });

  factory ShortlistedSport.fromJson(Map<String, dynamic> json) => ShortlistedSport(
    id: json["_id"],
    name: json["name"],
    categoryImage: json["category_image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "category_image": categoryImage,
  };
}
