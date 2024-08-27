// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_app/feature/food/domain/entity/food_entity.dart';
// import 'package:flutter_app/feature/food/presentaion/bloc/food_bloc/food_bloc.dart';
// import 'package:flutter_app/feature/food/presentaion/bloc/food_bloc/food_event.dart';

// class FoodCard extends StatefulWidget {
//   final List<FoodEntity> foods;

//   const FoodCard({Key? key, required this.foods}) : super(key: key);

//   @override
//   _FoodCardState createState() => _FoodCardState();
// }

// class _FoodCardState extends State<FoodCard> {
//   Map<String, bool> favorites = {};

//   @override
//   void initState() {
//     super.initState();
//     for (var food in widget.foods) {
//       favorites[food.id] = false;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GridView.count(
//       crossAxisCount: 2,
//       childAspectRatio: 0.8,
//       padding: const EdgeInsets.all(8),
//       mainAxisSpacing: 8,
//       crossAxisSpacing: 8,
//       children: widget.foods.map((food) {
//         return GestureDetector(
//           onTap: () {
//             final detailBloc =
//                 BlocProvider.of<DetailBloc>(context, listen: false);
//             detailBloc.add(FetchFoodDetailEvent(food.id));
//             Navigator.of(context).pushNamed('/detail');
//           },
//           child: Card(
//             margin: EdgeInsets.all(8),
//             elevation: 4,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(14),
//             ),
//             child: Stack(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Stack(
//                       children: [
//                         AspectRatio(
//                           aspectRatio: 2 / 1,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Image.network(
//                               food.imageUrl,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           right: 8,
//                           top: 8,
//                           child: IconButton(
//                             icon: Icon(
//                               favorites[food.id] == true
//                                   ? Icons.favorite
//                                   : Icons.favorite_border,
//                               color: favorites[food.id] == true
//                                   ? Colors.red
//                                   : Colors.grey,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 favorites[food.id] = !favorites[food.id]!;
//                               });
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             food.title,
//                             style: const TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           Row(
//                             children: [
//                               Icon(Icons.star, color: Colors.yellow, size: 16),
//                               SizedBox(width: 4),
//                               Text(
//                                 "${food.rating.toStringAsFixed(1)}",
//                                 style: const TextStyle(color: Colors.grey),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 8),
//                           Row(
//                             children: [
//                               Text(
//                                 "\$${food.price.toStringAsFixed(2)}",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.grey,
//                                   decoration: TextDecoration.lineThrough,
//                                 ),
//                               ),
//                               SizedBox(width: 8),
//                               Text(
//                                 "-\$${food.discount.toStringAsFixed(2)}",
//                                 style: const TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.red),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/feature/food/domain/entity/food_entity.dart';
import 'package:flutter_app/feature/food/presentaion/bloc/food_bloc/food_bloc.dart';
import 'package:flutter_app/feature/food/presentaion/bloc/food_bloc/food_event.dart';

class FoodCard extends StatefulWidget {
  final List<FoodEntity> foods;

  const FoodCard({Key? key, required this.foods}) : super(key: key);

  @override
  _FoodCardState createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  Map<String, bool> favorites = {};

  @override
  void initState() {
    super.initState();
    for (var food in widget.foods) {
      favorites[food.id] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 0.67,
      padding: const EdgeInsets.all(8),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: widget.foods.map((food) {
        return GestureDetector(
          onTap: () {
            final detailBloc =
                BlocProvider.of<DetailBloc>(context, listen: false);
            detailBloc.add(FetchFoodDetailEvent(food.id));
            Navigator.of(context).pushNamed('/detail');
          },
          child: Card(
            margin: EdgeInsets.all(8),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.17,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(14)),
                          child: Image.network(
                            food.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: IconButton(
                        icon: Icon(
                          favorites[food.id] == true
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: favorites[food.id] == true
                              ? Colors.red
                              : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            favorites[food.id] = !favorites[food.id]!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food.title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow, size: 16),
                          SizedBox(width: 4),
                          Text(
                            "${food.rating.toStringAsFixed(1)}",
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            "\$${food.price.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "\$${food.discount.toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
