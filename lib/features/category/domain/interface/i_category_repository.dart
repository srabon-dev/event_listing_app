import 'package:dartz/dartz.dart';
import '../../../../app_export.dart';

abstract class ICategoryRepository {
  Future<Either<Failure, CategoryModel>> getCategory({
    required String url,
  });
}
