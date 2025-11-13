import 'package:dartz/dartz.dart';
import '../../../../app_export.dart';

class CategoryRepository extends ICategoryRepository {
  final IApiClient apiClient;

  CategoryRepository({required this.apiClient});

  @override
  Future<Either<Failure, CategoryModel>> getCategory({required String url}) async {
    final response =  await apiClient.get(url: url);

    return response.fold((failure){
      return Left(failure);
    }, (success){
      final model = CategoryModel.fromJson(success.data);
      return Right(model);
    });
  }
}
