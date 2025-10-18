import 'package:event_listing_app/app_export.dart';

class ShortlistedCubit extends Cubit<void> {
  final ILocalService db;

  // final IInternetSatelliteRepository repository;
  final PagingController<int, String> pagingController;
  final PagingController<int, String> pagingController1;
  final PagingController<int, String> pagingController2;

  ShortlistedCubit({
    required this.pagingController,
    required this.pagingController1,
    required this.pagingController2,
    required this.db,
    // required this.repository,
  }) : super(null) {
    pagingController.addPageRequestListener((pageKey) {
      get(pageKey: pageKey);
    });
    pagingController1.addPageRequestListener((pageKey) {
      get1(pageKey: pageKey);
    });
    pagingController2.addPageRequestListener((pageKey) {
      get2(pageKey: pageKey);
    });
  }

  bool isLoading = false;
  bool isLoading1 = false;
  bool isLoading2 = false;

  Future<void> get({required int pageKey}) async {
    if (isLoading) return;
    isLoading = true;

    try {
      await Future.delayed(const Duration(seconds: 2));

      pagingController.appendLastPage([
        "https://picsum.photos/450/300",
        "https://picsum.photos/450/300",
        "https://picsum.photos/450/300",
        "https://picsum.photos/450/300",
        "https://picsum.photos/450/300",
      ]);
      /*final token = await db.getToken();
      final Either<Failure, String> response = await repository.getAll(
        url: ApiUrls.internetSatelliteGetAll(page: pageKey),
        token: token,
      );

      response.fold(
        (failure) {
          pagingController.error = failure.message;
        },
        (value) {
          final newItems = value.internetSatellite ?? [];
          if (newItems.isEmpty) {
            pagingController.appendLastPage(newItems);
          } else {
            pagingController.appendPage(newItems, pageKey + 1);
          }
        },
      );*/
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
      await Future.delayed(const Duration(seconds: 2));

      pagingController1.appendLastPage([
        "https://picsum.photos/450/300",
        "https://picsum.photos/450/300",
        "https://picsum.photos/450/300",
        "https://picsum.photos/450/300",
        "https://picsum.photos/450/300",
      ]);
      /*final token = await db.getToken();
      final Either<Failure, String> response = await repository.getAll(
        url: ApiUrls.internetSatelliteGetAll(page: pageKey),
        token: token,
      );

      response.fold(
        (failure) {
          pagingController.error = failure.message;
        },
        (value) {
          final newItems = value.internetSatellite ?? [];
          if (newItems.isEmpty) {
            pagingController.appendLastPage(newItems);
          } else {
            pagingController.appendPage(newItems, pageKey + 1);
          }
        },
      );*/
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
      await Future.delayed(const Duration(seconds: 2));

      pagingController2.appendLastPage([
        "https://picsum.photos/450/300",
        "https://picsum.photos/450/300",
        "https://picsum.photos/450/300",
        "https://picsum.photos/450/300",
        "https://picsum.photos/450/300",
      ]);
      /*final token = await db.getToken();
      final Either<Failure, String> response = await repository.getAll(
        url: ApiUrls.internetSatelliteGetAll(page: pageKey),
        token: token,
      );

      response.fold(
        (failure) {
          pagingController.error = failure.message;
        },
        (value) {
          final newItems = value.internetSatellite ?? [];
          if (newItems.isEmpty) {
            pagingController.appendLastPage(newItems);
          } else {
            pagingController.appendPage(newItems, pageKey + 1);
          }
        },
      );*/
    } catch (e) {
      pagingController2.error = 'An error occurred';
    } finally {
      isLoading2 = false;
    }
  }
}
