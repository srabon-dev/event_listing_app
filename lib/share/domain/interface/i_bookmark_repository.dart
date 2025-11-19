import 'package:dartz/dartz.dart';
import 'package:event_listing_app/app_export.dart';

abstract class IBookmarkRepository {
  Future<Either<Failure, Response>> toggleBookmark({required String token, required String url});
}