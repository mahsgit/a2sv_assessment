import 'dart:convert';
import 'package:flutter_app/feature/food/domain/entity/food_entity.dart';

class FoodModel extends FoodEntity {
  FoodModel({
    required String id,
    required String title,
    required String imageUrl,
    required double rating,
    required double price,
    required double discount,
    required String description,
    required List<FoodOptionModel> options,
  }) : super(
          id: id,
          title: title,
          imageUrl: imageUrl,
          rating: rating,
          price: price,
          discount: discount,
          description: description,
          options: options,
        );

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      rating: (json['rating'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      description: json['description'],
      options: (json['options'] as List<dynamic>)
          .map((option) => FoodOptionModel.fromJson(option))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'rating': rating,
      'price': price,
      'discount': discount,
      'description': description,
      'options': options.map((option) => option.toJson()).toList(),
    };
  }
}

class FoodOptionModel extends FoodOption {
  FoodOptionModel({
    required String id,
    required String name,
    required double price,
  }) : super(
          id: id,
          name: name,
          price: price,
        );
       Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };}

  factory FoodOptionModel.fromJson(Map<String, dynamic> json) {
    return FoodOptionModel(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
    );
  }

 
  }

