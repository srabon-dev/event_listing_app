import 'package:dartz/dartz.dart';
import '../../../../app_export.dart';

abstract class IEventDetailsRepository {
  Future<Either<Failure, EventDetailsEntity>> getEventDetails({
    required String token,
    required String url,
  });
}