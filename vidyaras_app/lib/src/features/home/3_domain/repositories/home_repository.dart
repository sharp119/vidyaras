import 'package:fpdart/fpdart.dart';
import '../../../../shared/domain/failures/failure.dart';
import '../models/home_data.dart';

/// Home repository interface
/// Defines contract for fetching home screen data
abstract class HomeRepository {
  /// Fetches all data needed for the home screen
  /// Returns Either<Failure, HomeData>
  Future<Either<Failure, HomeData>> getHomeData();

  /// Refreshes home data
  Future<Either<Failure, HomeData>> refreshHomeData();
}
