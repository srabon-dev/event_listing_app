import 'package:event_listing_app/app_export.dart';

class EventListCubit extends Cubit<void> {
  final ILocalService db;

  final IHomeRepository repository;
  final PagingController<int, OrganizerEventItem> pagingController;

  EventListCubit({
    required this.pagingController,
    required this.db,
    required this.repository,
  }) : super(null);

  bool isLoadingMove = false;

  Future<void> get({required int pageKey}) async {
    if (isLoadingMove) return;
    isLoadingMove = true;

    try {
      final token = await db.getToken();
      final response = await repository.getMyAllEvents(
        url: ApiUrls.getAllEvents(page: pageKey),
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
