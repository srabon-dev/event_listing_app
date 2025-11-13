class ManagementEntities {
  final String id;
  final String name;
  final String? shortDescription;
  final String? description;
  final String? sport;
  final String? eventType;
  final DateTime eventStart;
  final DateTime eventEnd;
  final num? minAge;
  final num? maxAge;
  final String? skillLevel;
  final num? availableSlot;
  final String? city;
  final String? address;
  final String? image;
  final num? rating;

  ManagementEntities({
    required this.id,
    required this.name,
    this.shortDescription,
    this.description,
    this.sport,
    this.eventType,
    required this.eventStart,
    required this.eventEnd,
    this.minAge,
    this.maxAge,
    this.skillLevel,
    this.availableSlot,
    this.city,
    this.address,
    this.image,
    this.rating,
  });
}
