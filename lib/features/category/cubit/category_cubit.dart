import 'package:event_listing_app/app_export.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final ICategoryRepository repository;

  CategoryCubit({required this.repository}) : super(CategoryLoading()) {
    getCategories();
  }

  Future<void> getCategories() async {
    try {
      emit(CategoryLoading());
      final result = await repository.getCategory(url: ApiUrls.category());

      result.fold(
        (failure) => emit(CategoryError(failure.message)),
        (response) => emit(CategoryLoaded(categories: response)),
      );
    } catch (e) {
      emit(const CategoryError('Failed to load categories'));
    }
  }
}
