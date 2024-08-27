import 'package:flutter_app/feature/food/domain/repository/foor_repository_contrat.dart';
import 'package:flutter_app/feature/food/domain/usecases/get_all_food_usecase.dart';
import 'package:flutter_app/feature/food/domain/usecases/get_food_by_id_usecase.dart';
import 'package:flutter_app/feature/food/presentaion/bloc/cart_bloc/cart_bloc.dart';
import 'package:flutter_app/feature/food/presentaion/bloc/food_bloc/food_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/feature/food/data/data_source/food_local_data_source.dart';
import 'package:flutter_app/feature/food/data/data_source/food_remote_data_source.dart';
import 'package:flutter_app/feature/food/data/repository/food_repository_impl.dart';
import 'package:flutter_app/core/platform/network_info.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  var sharedPreferences = await SharedPreferences.getInstance();
  var client = http.Client();
  var internetChecker = InternetConnectionChecker();

  getIt.registerFactory<NetworkInfo>(() => NetworkInfoImpl(internetChecker));
  getIt.registerSingleton<FoodRemoteDataSource>(
      FoodRemoteDataSourceImpl(client: client));
  getIt.registerSingleton<FoodLocalDataSource>(
      FoodLocalDataSourceImpl(sharedPreferences: sharedPreferences));

  getIt.registerSingleton<FoodRepository>(FoodRepositoryImpl(
    remoteDataSource: getIt<FoodRemoteDataSource>(),
    localDataSource: getIt<FoodLocalDataSource>(),
    networkInfo: getIt<NetworkInfo>(),
  ));

  getIt.registerSingleton<GetAllFoodUseCase>(
      GetAllFoodUseCase(getIt<FoodRepository>()));
  getIt.registerSingleton<GetFoodByIdUseCase>(
      GetFoodByIdUseCase(getIt<FoodRepository>()));
  getIt.registerSingleton<FetchAllFoodBloc>(
      FetchAllFoodBloc(getAllFoodUseCase: getIt()));
  getIt.registerSingleton<DetailBloc>(DetailBloc(getFoodByIdUseCase: getIt()));
  getIt.registerSingleton<CartBloc>(CartBloc());
}
