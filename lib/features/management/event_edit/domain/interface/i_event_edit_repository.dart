import 'package:dartz/dartz.dart';
import '../../../../../app_export.dart';

abstract class IEventEditRepository {

  Future<Either<Failure, Response>> editEvent({
    required String token,
    required List<String> imagePath,
    required EventAddEntities body,
    required String url,
  });
}
