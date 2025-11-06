import 'package:dartz/dartz.dart';
import '../../../../app_export.dart';

abstract class IProfileEditRepository{

  Future<Either<Failure, Response>> profileEdit({
    String? name,
    String? businessName,
    String? imagePath,
    String? phone,
    String? address,
    required String url,
    required String token,
  });
}