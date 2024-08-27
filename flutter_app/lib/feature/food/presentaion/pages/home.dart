import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/feature/food/presentaion/bloc/food_bloc/food_bloc.dart';
import 'package:flutter_app/feature/food/presentaion/bloc/food_bloc/food_state.dart';
import 'package:flutter_app/feature/food/presentaion/widgets/display_food_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.fastfood_rounded),
                Text('Burger'),
              ],
            ),
          ),
        ),
        body: BlocBuilder<FetchAllFoodBloc, FoodState>(
          builder: (context, state) {
            if (state is FoodLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FoodLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(38.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: Icon(Icons.filter_alt),
                      ),
                      // onChanged: (value) {
                      //   BlocProvider.of<FetchAllFoodBloc>(context)
                      //       .add(SearchFoodEvent(value));
                      // },
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: FoodCard(foods: state.foodItems)),
                  ),
                ],
              );
            } else if (state is FoodError) {
              return Center(
                child: Text(state.message),
              );
            }
            return Container();
          },
        ));
  }
}
