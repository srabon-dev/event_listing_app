import 'package:event_listing_app/app_export.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final ILocalService db;

  CategoryCubit({required this.db}) : super(CategoryLoading()) {
    getCategories();
  }

  Future<void> getCategories() async {
    try {
      emit(CategoryLoading());

      await Future.delayed(const Duration(milliseconds: 800));

      final items = [
        {"name": "Soccer", "image": "https://www.svgrepo.com/show/475622/football.svg"},
        {"name": "Basketball", "image": "https://www.svgrepo.com/show/513271/basketball.svg"},
        {"name": "Rugby", "image": "https://www.svgrepo.com/show/398233/rugby-football.svg"},
        {"name": "Baseball", "image": "https://www.svgrepo.com/show/423170/sports-ball.svg"},
        {"name": "Soccer", "image": "https://www.svgrepo.com/show/475622/football.svg"},
        {"name": "Basketball", "image": "https://www.svgrepo.com/show/513271/basketball.svg"},
        {"name": "Rugby", "image": "https://www.svgrepo.com/show/398233/rugby-football.svg"},
        {"name": "Baseball", "image": "https://www.svgrepo.com/show/423170/sports-ball.svg"},
        {"name": "Soccer", "image": "https://www.svgrepo.com/show/475622/football.svg"},
        {"name": "Basketball", "image": "https://www.svgrepo.com/show/513271/basketball.svg"},
        {"name": "Rugby", "image": "https://www.svgrepo.com/show/398233/rugby-football.svg"},
        {"name": "Baseball", "image": "https://www.svgrepo.com/show/423170/sports-ball.svg"},
      ];

      emit(CategoryLoaded(items));
    } catch (e) {
      emit(const CategoryError('Failed to load categories'));
    }
  }
}

