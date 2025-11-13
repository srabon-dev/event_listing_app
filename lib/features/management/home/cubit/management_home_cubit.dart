import 'package:dartz/dartz.dart';
import 'package:event_listing_app/app_export.dart';

class ManagementHomeCubit extends Cubit<void> {
  final ILocalService db;
  final IManagementHomeRepository repository;
  final PagingController<int, OrganizerEventItem> pagingController;

  ManagementHomeCubit({
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
      final Either<Failure, OrganizerEventModel> response = await repository.getMyAllEvents(
        url: ApiUrls.getMyEvents(page: pageKey),
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
