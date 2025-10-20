import 'package:event_listing_app/app_export.dart';

class CategoryEventsCubit extends Cubit<void> {
  final ILocalService db;

  // final IInternetSatelliteRepository repository;
  final PagingController<int, String> pagingController;

  CategoryEventsCubit({
    required this.pagingController,
    required this.db,
    // required this.repository,
  }) : super(null) {
    pagingController.addPageRequestListener((pageKey) {
      get(pageKey: pageKey);
    });
  }

  bool isLoadingMove = false;

  Future<void> get({required int pageKey}) async {
    if (isLoadingMove) return;
    isLoadingMove = true;

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
      isLoadingMove = false;
    }
  }
}
