import 'package:dartz/dartz.dart';
import '../../../../app_export.dart';

abstract class IProfileEditRepository{

  Future<Either<Failure, Response>> profileEdit({
    String? name,
    String? imagePath,
    String? currentMileage,
    required String url,
    required String token,
  });

  Future<Either<Failure, Response>> changeRv({
    required String rvId,
    required String token,
    required String url,
  });

  Future<Either<Failure, Response>> deleteRv({
    required String token,
    required String url,
  });
}