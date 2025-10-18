import 'package:dartz/dartz.dart';
import 'package:event_listing_app/app_export.dart';

class SearchScreenCubit extends Cubit<void> {
  final PagingController<int, String> pagingController;
  final ILocalService db;
  // final IReportRepository repository;

  SearchScreenCubit({
    required this.pagingController,
    required this.db,
    // required this.repository,
  }) : super(null) {
    pagingController.addPageRequestListener((pageKey) {
      get(pageKey: pageKey);
    });
  }

  bool isLoadingMove = false;

  String? search;
  DateTime? fromDate;
  DateTime? toDate;

  void setSearch(String? value) {
    search = value?.isNotEmpty == true ? value : null;
    pagingController.refresh();
  }

  void setDateRange(DateTime? start, DateTime? end) {
    fromDate = start;
    toDate = end;
    pagingController.refresh();
  }

  void resetFilters() {
    search = null;
    fromDate = null;
    toDate = null;
    pagingController.refresh();
  }

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
      final Either<Failure, List<ReportItem>?> response = await repository.getAll(
        url: ApiUrls.reportsGetAll(
          fromDate: fromDate,
          toDate: toDate,
          page: pageKey,
          limit: 20,
          search: search,
        ),
        token: token,
      );

      response.fold((failure) {
          pagingController.error = failure.message;
        }, (value) {
          final newItems = value ?? [];
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
