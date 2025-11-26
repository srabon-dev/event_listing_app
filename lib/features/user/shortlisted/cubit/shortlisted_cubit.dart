import 'package:event_listing_app/app_export.dart';

class ShortlistedCubit extends Cubit<void> {
  final ILocalService db;

  final IShortlistedRepository repository;
  final PagingController<int, ShortlistedItem> pagingController;
  final PagingController<int, ShortlistedItem> pagingController1;
  final PagingController<int, ShortlistedItem> pagingController2;
  final PagingController<int, ShortlistedItem> pagingController3;

  ShortlistedCubit({
    required this.pagingController,
    required this.pagingController1,
    required this.pagingController2,
    required this.pagingController3,
    required this.db,
    required this.repository,
  }) : super(null);

  bool isLoading = false;
  bool isLoading1 = false;
  bool isLoading2 = false;
  bool isLoading3 = false;

  Future<void> get({required int pageKey}) async {
    if (isLoading) return;
    isLoading = true;

    try {
      final token = await db.getToken();
      final response = await repository.getShortlistedEvents(
        url: ApiUrls.getFavoriteEvents(page: pageKey, status: "UPCOMING"),
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
      isLoading = false;
    }
  }

  Future<void> get1({required int pageKey}) async {
    if (isLoading1) return;
    isLoading1 = true;

    try {
      final token = await db.getToken();
      final response = await repository.getShortlistedEvents(
        url: ApiUrls.getFavoriteEvents(page: pageKey, status: "REGISTRATION_OPEN"),
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
        url: ApiUrls.getFavoriteEvents(page: pageKey, status: "EVENT_STARTED"),
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
      pagingController2.error = 'An error occurred';
    } finally {
      isLoading2 = false;
    }
  }

  Future<void> get3({required int pageKey}) async {
    if (isLoading3) return;
    isLoading3 = true;

    try {
      final token = await db.getToken();
      final response = await repository.getShortlistedEvents(
        url: ApiUrls.getFavoriteEvents(page: pageKey, status: "EVENT_FINISHED"),
        token: token,
      );

      response.fold((failure) {
        pagingController3.error = failure.message;
      }, (value) {
        final newItems = value.data?.result ?? [];
        if (newItems.isEmpty) {
          pagingController3.appendLastPage(newItems);
        } else {
          pagingController3.appendPage(newItems, pageKey + 1);
        }
      },
      );
    } catch (e) {
      pagingController3.error = 'An error occurred';
    } finally {
      isLoading3 = false;
    }
  }
}
