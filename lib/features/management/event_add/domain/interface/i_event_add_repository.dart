import 'package:dartz/dartz.dart';
import '../../../../../app_export.dart';

abstract class IEventAddRepository {
  Future<Either<Failure, Response>> addEvent({
    required String token,
    required List<String> imagePath,
    required EventAddEntities body,
    required String url,
  });
}
