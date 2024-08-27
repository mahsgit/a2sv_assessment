import 'package:flutter/material.dart';
import 'package:flutter_app/feature/food/presentaion/bloc/cart_bloc/cart_bloc.dart';
import 'package:flutter_app/feature/food/presentaion/bloc/cart_bloc/cart_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/feature/food/presentaion/bloc/food_bloc/food_bloc.dart';
import 'package:flutter_app/feature/food/presentaion/bloc/food_bloc/food_state.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _addCheese = false;
  bool _addBacon = false;
  bool _addMeat = false;

  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailBloc, FoodState>(
        builder: (context, state) {
          if (state is FoodLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FoodDetailLoaded) {
            final food = state.foodItem;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 1 / 3,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Image.network(
                          food.imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                        Positioned(
                          left: 10,
                          top: 10,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        Positioned(
  right: 10,
  bottom: 10,
  child: IconButton(
    icon: Icon(Icons.favorite_border),
    color: Colors.red,
    onPressed: () {
      // Handle favorite icon press
    },
  ),
)

                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "\$${food.price.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "\$${food.discount.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.star,
                                    color: Colors.yellow, size: 20),
                                SizedBox(width: 4),
                                Text(
                                  "${food.rating.toStringAsFixed(1)}",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'See all reviews',
                                style: TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          food.description,
                          style: TextStyle(
                              fontSize: 16,
                              color: const Color.fromARGB(255, 157, 157, 157)),
                        ),
                        SizedBox(height: 16),
                        SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Additional Options: ',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text('Add Cheese'),
                                ),
                                Text("+ 1.00"),
                                Checkbox(
                                  value: _addCheese,
                                  onChanged: (value) {
                                    setState(() {
                                      _addCheese = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text('Add Bacon'),
                                ),
                                Text("+ 1.00"),
                                Checkbox(
                                  value: _addBacon,
                                  onChanged: (value) {
                                    setState(() {
                                      _addBacon = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text('Add Meat'),
                                ),
                                Text("+ 1.00"),
                                Checkbox(
                                  value: _addMeat,
                                  onChanged: (value) {
                                    setState(() {
                                      _addMeat = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else if (state is FoodError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
      bottomNavigationBar: BlocBuilder<DetailBloc, FoodState>(
        builder: (context, state) {
          if (state is FoodDetailLoaded) {
            final food = state.foodItem;

            return BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove,
                            color: const Color.fromARGB(255, 0, 0, 0)),
                        onPressed: () {
                          if (_quantity > 1) {
                            setState(() {
                              _quantity--;
                            });
                          }
                        },
                      ),
                      Text('$_quantity',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0))),
                      IconButton(
                        icon: Icon(Icons.add,
                            color: const Color.fromARGB(255, 0, 0, 0)),
                        onPressed: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CartBloc>().add(AddToCart(
                            food: food,
                            quantity: _quantity,
                            addCheese: _addCheese,
                            addBacon: _addBacon,
                            addMeat: _addMeat,
                          ));
                      Navigator.of(context).pushNamed('/cart');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      minimumSize: Size(200, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text('Add to Basket',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return SizedBox
              .shrink(); // Return an empty widget if no food details are loaded
        },
      ),
    );
  }
}
