import 'package:flutter_app/feature/food/domain/entity/food_entity.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/feature/food/domain/entity/food_entity.dart';
import 'package:flutter_app/feature/food/data/model/food_model.dart';
import 'package:flutter_app/core/error/exception.dart';

abstract class FoodLocalDataSource{

  Future<void> cacheAllFood(List<FoodEntity> groceries);
  Future<List<FoodEntity>> getAllFoodLocal();
  Future<void> cacheFoodById(FoodEntity grocery);
  Future<FoodEntity> getFoodById(String id);
}


class FoodLocalDataSourceImpl implements FoodLocalDataSource {
  final SharedPreferences sharedPreferences;

  FoodLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheAllFood(List<FoodEntity> groceries) async {
    final List<Map<String, dynamic>> jsonList = 
        groceries.map((food) => (food as FoodModel).toJson()).toList();
    final jsonString = json.encode(jsonList);
    await sharedPreferences.setString('cached_all_food', jsonString);
  }

  @override
  Future<List<FoodEntity>> getAllFoodLocal() async {
    final jsonString = sharedPreferences.getString('cached_all_food');
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList
          .map((jsonItem) => FoodModel.fromJson(jsonItem))
          .toList();
    } else {
      throw CacheException(message: 'No cached food data found.');
    }
  }

  @override
  Future<void> cacheFoodById(FoodEntity grocery) async {
    final jsonString = json.encode((grocery as FoodModel).toJson());
    await sharedPreferences.setString('cached_food_${grocery.id}', jsonString);
  }

  @override
  Future<FoodEntity> getFoodById(String id) async {
    final jsonString = sharedPreferences.getString('cached_food_$id');
    if (jsonString != null) {
      return FoodModel.fromJson(json.decode(jsonString));
    } else {
      throw CacheException(message: 'No cached food data found for id: $id');
    }
  }
}
