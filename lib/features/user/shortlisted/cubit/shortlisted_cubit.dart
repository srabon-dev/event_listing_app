import 'package:event_listing_app/app_export.dart';

class ShortlistedCubit extends Cubit<void> {
  final ILocalService db;

  final IShortlistedRepository repository;
  final PagingController<int, OrganizerEventItem> pagingController;
  final PagingController<int, OrganizerEventItem> pagingController1;
  final PagingController<int, OrganizerEventItem> pagingController2;

  ShortlistedCubit({
    required this.pagingController,
    required this.pagingController1,
    required this.pagingController2,
    required this.db,
    required this.repository,
  }) : super(null);

  bool isLoading = false;
  bool isLoading1 = false;
  bool isLoading2 = false;

  Future<void> get({required int pageKey}) async {
    if (isLoading) return;
    isLoading = true;

    try {
      final token = await db.getToken();
      final response = await repository.getShortlistedEvents(
        url: ApiUrls.getAllEvents(page: pageKey, status: "REGISTRATION_OPEN"),
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
      print(e.toString());
      pagingController.error = 'An error occurred';
    } finally {
      isLoading = false;
    }
  }

  Future<void> get1({required int pageKey}) async {
    if (isLoading1) return;
    isLoading1 = true;

    try {
      final token = await db.getToken();
      final response = await repository.getShortlistedEvents(
        url: ApiUrls.getAllEvents(page: pageKey, status: "EVENT_STARTED"),
        token: token,
      );

      response.fold((failure) {
        pagingController1.error = failure.message;
      }, (value) {
        final newItems = value.data?.result ?? [];
        if (newItems.isEmpty) {
          pagingController1.appendLastPage(newItems);
        } else {
          pagingController1.appendPage(newItems, pageKey + 1);
        }
      },
      );
    } catch (e) {
      print(e.toString());
      pagingController1.error = 'An error occurred';
    } finally {
      isLoading1 = false;
    }
  }

  Future<void> get2({required int pageKey}) async {
    if (isLoading2) return;
    isLoading2 = true;

    try {
      final token = await db.getToken();
      final response = await repository.getShortlistedEvents(
        url: ApiUrls.getAllEvents(page: pageKey, status: "EVENT_FINISHED"),
        token: token,
      );

      response.fold((failure) {
        pagingController2.error = failure.message;
      }, (value) {
        final newItems = value.data?.result ?? [];
        if (newItems.isEmpty) {
          pagingController2.appendLastPage(newItems);
        } else {
          pagingController2.appendPage(newItems, pageKey + 1);
        }
      },
      );
    } catch (e) {

      print(e.toString());
      pagingController2.error = 'An error occurred';
    } finally {
      isLoading2 = false;
    }
  }
}
