import 'package:flutter/material.dart';
import 'package:flutter_app/feature/food/domain/entity/food_entity.dart';

class CartWidget extends StatelessWidget {
  final FoodEntity food;
  final int quantity;
  final bool addCheese;
  final bool addBacon;
  final bool addMeat;
  final Function onRemove;
  final Function(int) onUpdateQuantity;

  const CartWidget({
    Key? key,
    required this.food,
    required this.quantity,
    required this.addCheese,
    required this.addBacon,
    required this.addMeat,
    required this.onRemove,
    required this.onUpdateQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double itemPrice =
        (food.price) * quantity + (addCheese ? 1.0 : 0) + (addBacon ? 1.0 : 0);
    ;
    final double discount = food.discount;
    final double finalPrice =
        (discount) * quantity + (addCheese ? 1.0 : 0) + (addBacon ? 1.0 : 0);

    return Card(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(children: [
          ListTile(
            contentPadding: EdgeInsets.all(8),
            leading: Image.network(
              food.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            title: Text(food.title),
            subtitle: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "\$${itemPrice.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "\$${finalPrice.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () => onUpdateQuantity(quantity - 1),
                    ),
                    Text('$quantity'),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => onUpdateQuantity(quantity + 1),
                    ),
                  ],
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => onRemove(),
            ),
          ),
          if (addCheese || addBacon || addMeat)
            Column(
              children: [
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (addCheese)
                        Row(
                          children: [
                            Text('Add Cheese'),
                            Spacer(),
                            Text(
                              '+ \$1.00',
                              style: TextStyle(
                                  color: Colors
                                      .orange), // Set text color to orange
                            ),
                          ],
                        ),
                      if (addBacon)
                        Row(
                          children: [
                            Text('Add Bacon'),
                            Spacer(),
                            Text(
                              '+ \$1.00',
                              style: TextStyle(
                                  color: Colors
                                      .orange), // Set text color to orange
                            ),
                          ],
                        ),
                      if (addMeat)
                        Row(
                          children: [
                            Text('Add Meat'),
                            Spacer(),
                            Text(
                              '+ \$1.00',
                              style: TextStyle(
                                  color: Colors
                                      .orange), // Set text color to orange
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
        ]));
  }
}
