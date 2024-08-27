import 'package:bloc/bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';
class CartBloc extends Bloc<CartEvent, CartState> {
  List<Map<String, dynamic>> _cartItems = [];

  CartBloc() : super(CartInitial()) {
    on<AddToCart>((event, emit) {
      emit(CartLoading());

      try {
        // Find the index of the existing item by its ID
        final existingCartItemIndex = _cartItems.indexWhere(
          (item) => item['food'].id == event.food.id,
        );

        if (existingCartItemIndex >= 0) {
          // Update the quantity and options if the item already exists
          _cartItems[existingCartItemIndex]['quantity'] =
              event.quantity; // Set the new quantity directly
          _cartItems[existingCartItemIndex]['addCheese'] = event.addCheese;
          _cartItems[existingCartItemIndex]['addBacon'] = event.addBacon;
          _cartItems[existingCartItemIndex]['addMeat'] = event.addMeat;
        } else {
          // Add a new item if it doesn't exist
          final cartItem = {
            'food': event.food,
            'quantity': event.quantity,
            'addCheese': event.addCheese,
            'addBacon': event.addBacon,
            'addMeat': event.addMeat,
          };
          _cartItems.add(cartItem);
        }

        emit(CartLoaded(carts: _cartItems));
      } catch (e) {
        emit(CartError(message: "Failed to add item to cart"));
      }
    });

    on<RemoveFromCart>((event, emit) {
      emit(CartLoading());

      try {
        _cartItems.removeWhere((item) => item['food'] == event.food);
        emit(CartLoaded(carts: _cartItems));
      } catch (e) {
        emit(CartError(message: "Failed to remove item from cart"));
      }
    });
  }
}
