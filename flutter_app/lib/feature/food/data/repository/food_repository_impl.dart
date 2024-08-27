import 'package:dartz/dartz.dart';
import 'package:flutter_app/core/error/exception.dart';
import 'package:flutter_app/core/platform/network_info.dart';
import 'package:flutter_app/feature/food/data/data_source/food_local_data_source.dart';
import 'package:flutter_app/feature/food/data/data_source/food_remote_data_source.dart';
import 'package:flutter_app/feature/food/domain/entity/food_entity.dart';
import 'package:flutter_app/core/error/failures.dart';
import 'package:flutter_app/feature/food/domain/repository/foor_repository_contrat.dart';

class FoodRepositoryImpl extends FoodRepository {
  final FoodRemoteDataSource remoteDataSource;
  final FoodLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  FoodRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<FoodEntity>>> getAllGroceriesRepo() async {
    if (await networkInfo.isconnected) {
      try {
        final remoteGroceries = await remoteDataSource.getAllFoodsRemote();
        localDataSource.cacheAllFood(remoteGroceries);
        return Right(remoteGroceries);
      } on ServerException {
        return const Left(ServerFailure('Failed to fetch groceries from server.'));
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      } catch (e) {
        return const Left(ServerFailure('Unexpected error occurred.'));
      }
    } else {
      try {
        final localGroceries = await localDataSource.getAllFoodLocal();
        return Right(localGroceries);
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      } catch (e) {
        return const Left(CacheFailure('Unexpected error occurred while fetching from local cache.'));
      }
    }
  }




  @override
  Future<Either<Failure, FoodEntity>> getGroceryByIdRepo(String id) async {
    if (await networkInfo.isconnected) {
      try {
        final remoteGrocery = await remoteDataSource.getFoodByIdRemote(id);
        localDataSource.cacheFoodById(remoteGrocery);
        return Right(remoteGrocery);
      } on ServerException {
        return const Left(ServerFailure('Failed to fetch grocery details from server.'));
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      } catch (e) {
        return const Left(ServerFailure('Unexpected error occurred.'));
      }
    } else {
      try {
        final localGrocery = await localDataSource.getFoodById(id);
        return Right(localGrocery);
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      } catch (e) {
        return const Left(CacheFailure('Unexpected error occurred while fetching from local cache.'));
      }
    }
  }
}
