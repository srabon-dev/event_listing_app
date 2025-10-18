class EventCardEntity {
  final String? title;
  final String? location;
  final String? coverImage;
  final DateTime? eventDateStart;
  final DateTime? eventDateEnd;
  final String? ages;
  final String? category;
  final String? ratings;
  final String id;

  const EventCardEntity({
    this.title,
    this.location,
    this.coverImage,
    this.eventDateStart,
    this.eventDateEnd,
    this.ages,
    this.category,
    this.ratings,
    required this.id,
  });
}