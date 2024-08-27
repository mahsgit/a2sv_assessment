import 'package:dartz/dartz.dart';
import 'package:flutter_app/feature/food/domain/entity/food_entity.dart';
import '../../../../core/error/failures.dart';

abstract class FoodRepository {
  Future<Either<Failure, List<FoodEntity>>> getAllGroceriesRepo();
  Future<Either<Failure, FoodEntity>> getGroceryByIdRepo(String id);
}
