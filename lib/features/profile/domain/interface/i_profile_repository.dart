import 'package:dartz/dartz.dart';
import '../../../../app_export.dart';

abstract class IProfileRepository{
  Future<Either<Failure, ProfileEntity>> getProfile({
    required String token,
    required String url,
  });
}