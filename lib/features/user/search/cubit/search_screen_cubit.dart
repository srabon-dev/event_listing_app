import 'package:event_listing_app/app_export.dart';

class SearchScreenCubit extends Cubit<void> {
  final PagingController<int, OrganizerEventItem> pagingController;
  final ILocalService db;
  final ISearchRepository repository;

  SearchScreenCubit({
    required this.pagingController,
    required this.db,
    required this.repository,
  }) : super(null);

  bool isLoadingMove = false;

  Future<void> get({
    required int pageKey,
    String? status,
    String? searchTerm,
    String? sport,
    String? eventType,
    String? selectedAge,
    String? skillLevel,
    String? zipCode,
  }) async {
    if (isLoadingMove) return;
    isLoadingMove = true;

    const validStatuses = [
      "REGISTRATION_OPEN",
      "EVENT_STARTED",
      "EVENT_FINISHED",
    ];

    String? mapToEnumStatus(String? status) {
      if (status == null || status.isEmpty) return null;

      final enumStatus = status.toUpperCase().replaceAll(' ', '_');

      return validStatuses.contains(enumStatus) ? enumStatus : null;
    }

    final selectedAges = selectedAge ?? "";

    int minAge = 0;
    int maxAge = 1000;

    if (selectedAges == "Any Age") {
      minAge = 0;
      maxAge = 1000;
    } else if (selectedAges.contains("–")) {
      final parts = selectedAges.split("–");
      minAge = int.tryParse(parts.first.trim()) ?? 0;
      maxAge = int.tryParse(parts.last.replaceAll(RegExp(r'[^0-9]'), '').trim()) ?? 1000;
    } else if (selectedAges.contains("+")) {
      minAge = int.tryParse(selectedAges.replaceAll(RegExp(r'[^0-9]'), '').trim()) ?? 0;
      maxAge = 1000;
    }

    try {
      final token = await db.getToken();
      final response = await repository.getSearchEvents(
        url: ApiUrls.getAllSearchEvents(
          page: pageKey,
          status: mapToEnumStatus(status),
          searchTerm: searchTerm,
          sport: sport,
          eventType: eventType,
          minAge: minAge,
          maxAge: maxAge,
          skillLevel: skillLevel,
          zipCode: zipCode,
        ),
        token: token,
      );

      response.fold((failure) {
          pagingController.error = failure.message;
        }, (value) {
          final newItems = value.data?.result ?? [];
          if (newItems.isEmpty) {
            pagingController.appendLastPage(newItems);
          } else {
            pagingController.appendPage(newItems, pageKey + 1);
          }
        },
      );
    } catch (e) {
      pagingController.error = 'An error occurred';
    } finally {
      isLoadingMove = false;
    }
  }
}
