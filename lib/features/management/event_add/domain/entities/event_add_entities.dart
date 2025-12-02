class EventAddEntities {
  final String name;
  final String shortDescription;
  final String sport;
  final String eventType;
  final DateTime registrationStartDate;
  final DateTime registrationEndDateTime;
  final DateTime eventStartDateTime;
  final DateTime eventEndDateTime;
  final int minAge;
  final int maxAge;
  final String skillLevel;
  final int availableSlot;
  final String zipCode;
  final String address;
  final double latitude;
  final double longitude;
  final String city;
  final String websiteLink;
  final double registrationFee;
  final String description;

  EventAddEntities({
    required this.name,
    required this.shortDescription,
    required this.sport,
    required this.eventType,
    required this.registrationStartDate,
    required this.registrationEndDateTime,
    required this.eventStartDateTime,
    required this.eventEndDateTime,
    required this.minAge,
    required this.maxAge,
    required this.skillLevel,
    required this.availableSlot,
    required this.zipCode,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.websiteLink,
    required this.registrationFee,
    required this.description,
  });

  Map<String, dynamic> toJson({bool isRemove = false}) {

    bool isValidNumber(num? v) {
      if (v == null) return false;
      if (!v.isFinite) return false;
      if (v.isNaN) return false;
      if (v == 0) return false;
      return true;
    }

    final hasValidCoordinates = isValidNumber(latitude) && isValidNumber(longitude);

    final data = <String, dynamic>{
      "name": name,
      "shortDescription": shortDescription,
      "sport": sport,
      "eventType": eventType,
      "registrationStartDateTime": registrationStartDate.toUtc().toIso8601String(),
      "registrationEndDateTime": registrationEndDateTime.toUtc().toIso8601String(),
      "eventStartDateTime": eventStartDateTime.toUtc().toIso8601String(),
      "eventEndDateTime": eventEndDateTime.toUtc().toIso8601String(),
      "minAge": minAge,
      "maxAge": maxAge,
      "skillLevel": skillLevel,
      "availableSlot": availableSlot,
      "zipCode": zipCode,
      "address": address,
      if (hasValidCoordinates)
        "location": {
          "type": "Point",
          "coordinates": [longitude, latitude],
        },
      "city": city,
      "websiteLink": websiteLink,
      "registrationFee": registrationFee,
      "description": description,
    };

    if (isRemove) {
      data.removeWhere((key, value) {
        if (value == null) return true;
        if (value is String && value.trim().isEmpty) return true;
        return false;
      });
    }

    return data;
  }
}
