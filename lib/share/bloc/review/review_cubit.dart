import 'package:event_listing_app/app_export.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final ILocalService db;
  final IReviewRepository repository;

  ReviewCubit({required this.repository, required this.db}) : super(ReviewInitial());

  bool isRunning = false;

  Future<void> addReview({required String event,required double rating,}) async {
    try {
      if(isRunning)return;
      isRunning = true;

      emit(const ReviewAdd(isLoading: true));
      final token = await db.getToken();

      final result = await repository.addReview(
        token: token,
        event: event,
        ratings: rating,
        url: ApiUrls.addRating(),
      );

      result.fold((failure) {
        emit(ReviewAdd(message: failure.message, isLoading: false));
      }, (profile) {
        emit(const ReviewAdd(isLoading: false, isVerified: true));
      },
      );
    } catch (e) {
      emit(ReviewAdd(message: e.toString(), isLoading: false));
    } finally {
      isRunning = false;
    }
  }
}
