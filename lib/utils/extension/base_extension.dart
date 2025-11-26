import 'package:event_listing_app/app_export.dart';

extension BasePathExtensions on String {
  String get addBasePath {
    return RoutePath.basePath + this;
  }
}

extension ContextExtensions on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  Color get primaryTextColor => isDarkMode ? AppColorsDark.primaryText : AppColors.primaryText;
  Color get secondaryTextColor => isDarkMode ? AppColorsDark.secondaryText : AppColors.secondaryText;
  Color get backgroundColor => isDarkMode ? AppColorsDark.backgroundColor : AppColors.backgroundColor;
  Color get brandHoverColor => isDarkMode ? AppColorsDark.brandHoverColor : AppColors.brandHoverColor;
  Color get softBrandColor => isDarkMode ? AppColorsDark.softBrandColor : AppColors.softBrandColor;
  Color get successColor => isDarkMode ? AppColorsDark.successColor : AppColors.successColor;
  Color get errorColor => isDarkMode ? AppColorsDark.errorColor : AppColors.errorColor;

  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;

  AppLocalizations get loc => AppLocalizations.of(this)!;

  TextTheme get textTheme => Theme.of(this).textTheme;

  TextStyle get headlineLarge => textTheme.headlineLarge!;
  TextStyle get headlineMedium => textTheme.headlineMedium!;
  TextStyle get headlineSmall => textTheme.headlineSmall!;
  TextStyle get titleLarge => textTheme.titleLarge!;
  TextStyle get titleMedium => textTheme.titleMedium!;
  TextStyle get titleSmall => textTheme.titleSmall!;
  TextStyle get bodyLarge => textTheme.bodyLarge!;
  TextStyle get bodyMedium => textTheme.bodyMedium!;
  TextStyle get bodySmall => textTheme.bodySmall!;
  TextStyle get labelLarge => textTheme.labelLarge!;
  TextStyle get labelMedium => textTheme.labelMedium!;
  TextStyle get labelSmall => textTheme.labelSmall!;
}

extension CategoryMapper on CategoryModel {
  List<CategoryEntities> toEntities() {
    final items = data?.result;
    if (items == null || items.isEmpty) return [];

    return items.where((item) {
      final idValid = item.id != null && item.id!.trim().isNotEmpty;

      return idValid;
    }).map((item) => CategoryEntities(
        id: item.id!,
        name: item.name ?? "Unknown",
        type: item.type ?? "",
        categoryImage: item.categoryImage ?? AppConfig.defaultCategory,
      ),
    ).toList();
  }

  List<CategoryEntities> getAll() => toEntities();

  List<CategoryEntities> getSports() => toEntities().where((e) => e.type.toLowerCase() == 'sports').toList();

  List<CategoryEntities> getEvents() => toEntities().where((e) => e.type.toLowerCase() == 'event').toList();
}


extension EventDetailsMapper on EventDetailsModel {
  EventDetailsEntity toEntity() => EventDetailsEntity(
    id: data?.id ?? '',
    name: data?.name ?? '',
    shortDescription: data?.shortDescription,
    description: data?.description,
    city: data?.city,
    address: data?.address,
    zipCode: data?.zipCode,
    websiteLink: data?.websiteLink,
    registrationFee: data?.registrationFee,
    availableSlot: data?.availableSlot,
    minAge: data?.minAge,
    maxAge: data?.maxAge,
    skillLevel: data?.skillLevel,
    isDeleted: data?.isDeleted,
    averageRating: data?.averageRating,
    totalRating: data?.totalRating,
    isBookmark: data?.isBookmark,
    ratingData: data?.ratingData != null ? EventDetailsRatingDataEntity(
      id: data!.ratingData!.id,
      event: data!.ratingData!.event,
      rating: data!.ratingData!.rating,
      user: data!.ratingData!.user != null ? EventDetailsRatingUserEntity(
        id: data!.ratingData!.user!.id,
        name: data!.ratingData!.user!.name,
        profileImage: data!.ratingData!.user!.profileImage,
      ) : null,
    ) : null,
    image: data?.image,
    status: data?.status,
    registrationStartDate: data?.registrationStartDateTime,
    registrationEndDateTime: data?.registrationEndDateTime,
    eventStartDateTime: data?.eventStartDateTime,
    eventEndDateTime: data?.eventEndDateTime,
    sport: data?.sport != null ? EventDetailsTypeEntity(
      id: data?.sport!.id ?? '',
      name: data?.sport!.name ?? '',
      type: data?.sport!.type,
      categoryImage: data?.sport!.categoryImage,
    ) : null,
    eventType: data?.eventType != null ? EventDetailsTypeEntity(
      id: data?.eventType!.id ?? '',
      name: data?.eventType!.name ?? '',
      type: data?.eventType!.type,
      categoryImage: data?.eventType!.categoryImage,
    ) : null,
    organizer: data?.organizer != null ? EventDetailsOrganizerEntity(
      id: data?.organizer!.id ?? '',
      name: data?.organizer!.name,
      businessName: data?.organizer!.businessName,
      email: data?.organizer!.email,
      phone: data?.organizer!.phone,
      address: data?.organizer!.address,
      profileImage: data?.organizer!.profileImage != null && data!.organizer!.profileImage!.isNotEmpty? data?.organizer!.profileImage : "https://picsum.photos/450/300" ,
    ) : null,
    location: data?.location != null ? EventDetailsLocationEntity(
      type: data?.location!.type,
      coordinates: data?.location!.coordinates,
    ) : null,
  );
}


extension OrganizerEventMapper on OrganizerEventItem {
  ManagementEntities toEntity() {
    return ManagementEntities(
      id: id ?? '',
      name: name ?? '',
      shortDescription: shortDescription,
      description: description,
      sport: sport?.name,
      eventType: eventType?.name,
      eventStart: eventStartDateTime ?? DateTime.now(),
      eventEnd: eventEndDateTime ?? DateTime.now(),
      minAge: minAge,
      maxAge: maxAge,
      skillLevel: skillLevel,
      availableSlot: availableSlot,
      city: city,
      address: address,
      image: image,
      rating: averageRating,
    );
  }
}

extension ShortlistedEventMapper on ShortlistedItem {
  ManagementEntities toItemEntity() {
    return ManagementEntities(
      id: event?.id ?? '',
      name: event?.name ?? '',
      shortDescription: event?.shortDescription,
      description: event?.description,
      sport: event?.sport?.name,
      eventType: event?.eventType?.name,
      eventStart: event?.eventStartDateTime ?? DateTime.now(),
      eventEnd: event?.eventEndDateTime ?? DateTime.now(),
      minAge: event?.minAge,
      maxAge: event?.maxAge,
      skillLevel: event?.skillLevel,
      availableSlot: event?.availableSlot,
      city: event?.city,
      address: event?.address,
      image: event?.image,
      rating: event?.avgRating,
    );
  }
}


