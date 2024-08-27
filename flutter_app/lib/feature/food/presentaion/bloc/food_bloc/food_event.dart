import 'package:equatable/equatable.dart';
import 'package:flutter_app/feature/food/domain/entity/food_entity.dart';

abstract class FoodEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchAllFoodEvent extends FoodEvent {}

class FetchFoodDetailEvent extends FoodEvent {
  final String id;
  FetchFoodDetailEvent(this.id);

  @override
  List<Object?> get props => [id];
}


class AddToCartEvent extends FoodEvent {
  final FoodEntity foodItem;

  AddToCartEvent(this.foodItem);

  @override
  List<Object?> get props => [foodItem];
}

class RemoveFromCartEvent extends FoodEvent {
  final String foodId;

  RemoveFromCartEvent(this.foodId);

  @override
  List<Object?> get props => [foodId];
}
