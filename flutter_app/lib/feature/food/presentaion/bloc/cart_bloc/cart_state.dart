
import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<Map<String, dynamic>> carts;

  CartLoaded({required this.carts});

  @override
  List<Object> get props => [carts];
}

class CartError extends CartState {
  final String message;

  CartError({required this.message});

  @override
  List<Object> get props => [message];
}
