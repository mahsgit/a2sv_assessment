import 'package:equatable/equatable.dart';
import 'package:flutter_app/feature/food/domain/entity/food_entity.dart';

abstract class CartEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  final FoodEntity food;
  final int quantity;
  final bool addCheese;
  final bool addBacon;
  final bool addMeat;

  AddToCart({required this.food, required this.quantity, required this.addCheese, required this.addBacon,required this.addMeat});

  @override
  List<Object> get props => [food, quantity, addCheese, addBacon];
}

class RemoveFromCart extends CartEvent {
  final FoodEntity food;

  RemoveFromCart({required this.food});

  @override
  List<Object> get props => [food];
}

