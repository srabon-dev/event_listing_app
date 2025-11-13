class EventDetailsEntity {
  final String id;
  final String name;
  final String? shortDescription;
  final String? description;
  final String? city;
  final String? address;
  final String? zipCode;
  final String? websiteLink;
  final num? registrationFee;
  final num? availableSlot;
  final num? minAge;
  final num? maxAge;
  final String? skillLevel;
  final bool? isDeleted;
  final num? averageRating;
  final String? image;
  final String? status;
  final DateTime? registrationStartDate;
  final DateTime? registrationEndDateTime;
  final DateTime? eventStartDateTime;
  final DateTime? eventEndDateTime;
  final EventDetailsTypeEntity? sport;
  final EventDetailsTypeEntity? eventType;
  final EventDetailsOrganizerEntity? organizer;
  final EventDetailsLocationEntity? location;

  const EventDetailsEntity({
    required this.id,
    required this.name,
    this.shortDescription,
    this.description,
    this.city,
    this.address,
    this.zipCode,
    this.websiteLink,
    this.registrationFee,
    this.availableSlot,
    this.minAge,
    this.maxAge,
    this.skillLevel,
    this.isDeleted,
    this.averageRating,
    this.image,
    this.status,
    this.registrationStartDate,
    this.registrationEndDateTime,
    this.eventStartDateTime,
    this.eventEndDateTime,
    this.sport,
    this.eventType,
    this.organizer,
    this.location,
  });
}

class EventDetailsTypeEntity {
  final String id;
  final String name;
  final String? type;
  final String? categoryImage;

  const EventDetailsTypeEntity({
    required this.id,
    required this.name,
    this.type,
    this.categoryImage,
  });
}

class EventDetailsOrganizerEntity {
  final String id;
  final String? name;
  final String? businessName;
  final String? email;
  final String? phone;
  final String? address;
  final String? profileImage;

  const EventDetailsOrganizerEntity({
    required this.id,
    this.name,
    this.businessName,
    this.email,
    this.phone,
    this.address,
    this.profileImage,
  });
}

class EventDetailsLocationEntity {
  final String? type;
  final List<double>? coordinates;

  const EventDetailsLocationEntity({
    this.type,
    this.coordinates,
  });
}
