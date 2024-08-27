import 'package:equatable/equatable.dart';
import 'package:flutter_app/feature/food/domain/entity/food_entity.dart';

abstract class FoodState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FoodInitial extends FoodState {}

class FoodLoading extends FoodState {}

class FoodLoaded extends FoodState {
  final List<FoodEntity> foodItems;

  FoodLoaded(this.foodItems);

  @override
  List<Object?> get props => [foodItems];
}

class FoodDetailLoaded extends FoodState {
  final FoodEntity foodItem;

  FoodDetailLoaded(this.foodItem);

  @override
  List<Object?> get props => [foodItem];
}

class CartUpdated extends FoodState {
  final List<FoodEntity> cartItems;

  CartUpdated(this.cartItems);

  @override
  List<Object?> get props => [cartItems];
}

class FoodError extends FoodState {
  final String message;

  FoodError(this.message);

  @override
  List<Object?> get props => [message];
}
