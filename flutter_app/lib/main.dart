import 'package:flutter/material.dart';
import 'package:flutter_app/core/DI.dart';
import 'package:flutter_app/feature/food/presentaion/bloc/cart_bloc/cart_bloc.dart';
import 'package:flutter_app/feature/food/presentaion/bloc/food_bloc/food_bloc.dart';
import 'package:flutter_app/feature/food/presentaion/bloc/food_bloc/food_event.dart';
import 'package:flutter_app/feature/food/presentaion/pages/basket.dart';
import 'package:flutter_app/feature/food/presentaion/pages/detail.dart';
import 'package:flutter_app/feature/food/presentaion/pages/home.dart';
import 'package:flutter_app/feature/food/presentaion/pages/splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setup();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
        create: (context) =>
            getIt.get<FetchAllFoodBloc>()..add(FetchAllFoodEvent())),
    BlocProvider(
      create: (context) => getIt.get<DetailBloc>(),
    ),
    BlocProvider(
      create: (context) => getIt.get<CartBloc>(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash',
        routes: {
          '/': (context) => Home(),
          '/detail': (context) => DetailPage(),
          '/cart': (context) => CartPage(),
          '/splash': (context) => Splash()
        });
  }
}
