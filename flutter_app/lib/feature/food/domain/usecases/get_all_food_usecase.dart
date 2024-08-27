import 'package:dartz/dartz.dart';
import 'package:flutter_app/core/error/failures.dart';
import 'package:flutter_app/core/usecases/usecase.dart';
import 'package:flutter_app/feature/food/domain/entity/food_entity.dart';
import 'package:flutter_app/feature/food/domain/repository/foor_repository_contrat.dart';

class GetAllFoodUseCase extends Usecase<List<FoodEntity>, NoParams> {
  final FoodRepository repository;

  GetAllFoodUseCase(this.repository);

  @override
  Future<Either<Failure, List<FoodEntity>>> call(NoParams params) async {
    return await repository.getAllGroceriesRepo();
  }
}
