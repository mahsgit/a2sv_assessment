import 'package:flutter/material.dart';
import 'package:flutter_app/feature/food/presentaion/bloc/cart_bloc/cart_bloc.dart';
import 'package:flutter_app/feature/food/presentaion/bloc/cart_bloc/cart_event.dart';
import 'package:flutter_app/feature/food/presentaion/bloc/cart_bloc/cart_state.dart';
import 'package:flutter_app/feature/food/presentaion/widgets/display_basket_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'My Basket',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order Summary',
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.orange, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Add Item',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 13,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: state is CartLoaded ? state.carts.length : 0,
                    itemBuilder: (context, index) {
                      final cartItem =
                          state is CartLoaded ? state.carts[index] : null;
                      if (cartItem == null) return SizedBox.shrink();
                      return CartWidget(
                        food: cartItem['food'],
                        quantity: cartItem['quantity'],
                        addCheese: cartItem['addCheese'],
                        addBacon: cartItem['addBacon'],
                        addMeat: cartItem['addMeat'],
                        onRemove: () {
                          context
                              .read<CartBloc>()
                              .add(RemoveFromCart(food: cartItem['food']));
                        },
                        onUpdateQuantity: (newQuantity) {
                          if (newQuantity > 0) {
                            context.read<CartBloc>().add(AddToCart(
                                  food: cartItem['food'],
                                  quantity: newQuantity,
                                  addCheese: cartItem['addCheese'],
                                  addBacon: cartItem['addBacon'],
                                  addMeat: cartItem['addMeat'],
                                ));
                          } else {
                            context
                                .read<CartBloc>()
                                .add(RemoveFromCart(food: cartItem['food']));
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 25,
            ),
            _buildSummarySection(context),
            SizedBox(
              height: 25,
            ),
            _buildBottomBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSummarySection(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        double subtotal = 0.0;
        double discount = 0.0;
        double realdiscount = 0.0;

        if (state is CartLoaded) {
          subtotal = state.carts.fold(0.0, (total, item) {
            final double itemPrice = item['food'].price;
            final int quantity = item['quantity'];
            return total + (itemPrice * quantity);
          });
          realdiscount = state.carts.fold(0.0, (totalDiscount, item) {
            final double itemDiscount = item['food'].discount;
            final int quantity = item['quantity'];
            return totalDiscount + (itemDiscount * quantity);
          });

          discount = state.carts.fold(0.0, (totalDiscount, item) {
            final double itemDiscount = item['food'].discount;
            final int quantity = item['quantity'];
            return subtotal - (totalDiscount + (itemDiscount * quantity));
          });
        }

        final double total = realdiscount;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Subtotal: '),
                Text(
                  '\$${subtotal.toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Delivery:'),
                Text(
                  'FREE',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Discount: '),
                Text(
                  '-\$${discount.toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total:"),
                Text(
                  ' \$${total.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        double subtotal = 0.0;
        double discount = 0.0;

        if (state is CartLoaded) {
          subtotal = state.carts.fold(0.0, (total, item) {
            final double itemPrice = item['food'].price;
            final int quantity = item['quantity'];
            return total + (itemPrice * quantity);
          });

          discount = state.carts.fold(0.0, (totalDiscount, item) {
            final double itemDiscount = item['food'].discount;
            final int quantity = item['quantity'];
            return totalDiscount + (itemDiscount * quantity);
          });
        }

        // final double total = subtotal - discount
        final double total = discount;

        return Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ' \$${total.toStringAsFixed(2)}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle place order action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text(
                  'Place Order',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
