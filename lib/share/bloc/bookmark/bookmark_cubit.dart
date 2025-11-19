import 'package:event_listing_app/app_export.dart';

part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  final ILocalService db;
  final IBookmarkRepository repository;

  BookmarkCubit({required this.repository, required this.db}) : super(BookmarkInitial());

  bool isRunning = false;

  Future<void> toggleBookmark({required String id}) async {
    try {
      if(isRunning)return;
      isRunning = true;

      emit(const BookmarkToggle(isLoading: true));
      final token = await db.getToken();

      final result = await repository.toggleBookmark(
        token: token,
        url: ApiUrls.toggleBookmark(id: id),
      );

      result.fold((failure) {
          emit(BookmarkToggle(message: failure.message, isLoading: false));
        }, (profile) {
          emit(const BookmarkToggle(isLoading: false, isVerified: true));
        },
      );
    } catch (e) {
      emit(BookmarkToggle(message: e.toString(), isLoading: false));
    } finally {
      isRunning = false;
    }
  }
}
