import 'package:flutter_app/core/constants/constants.dart';
import 'package:flutter_app/core/error/exception.dart';
import 'package:flutter_app/feature/food/data/model/food_model.dart';
import 'package:flutter_app/feature/food/domain/entity/food_entity.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data_source/food_remote_data_source.dart';
abstract class FoodRemoteDataSource{
  Future<List<FoodEntity>> getAllFoodsRemote();
  Future<FoodEntity> getFoodByIdRemote(String id);
}



class FoodRemoteDataSourceImpl extends FoodRemoteDataSource {
  final http.Client client;

  FoodRemoteDataSourceImpl({required this.client});

  @override
  Future<List<FoodEntity>> getAllFoodsRemote() async {
    final response = await client.get(Uri.parse(Urls.allfoodUrl()));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> foodList = data['data'];
      return foodList.map((item) => FoodModel.fromJson(item)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<FoodEntity> getFoodByIdRemote(String id) async {
    final response = await client.get(Uri.parse(Urls.foodbyidUrl(id)));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return FoodModel.fromJson(data['data']);
    } else {
      throw ServerException();
    }
  }
}