import 'package:dartz/dartz.dart';
import 'package:flutter_app/core/error/failures.dart';
import 'package:flutter_app/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/feature/food/domain/entity/food_entity.dart';
import 'package:flutter_app/feature/food/domain/repository/foor_repository_contrat.dart';

class GetFoodByIdUseCase extends Usecase<FoodEntity, FoodParams> {
  final FoodRepository repository;

  GetFoodByIdUseCase(this.repository);

  @override
  Future<Either<Failure, FoodEntity>> call(FoodParams params) async {
    return await repository.getGroceryByIdRepo(params.id);
  }
}

class FoodParams extends Equatable {
  final String id;
  const FoodParams({required this.id});

  @override
  List<Object?> get props => [id];
}
