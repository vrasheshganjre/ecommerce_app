// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int productId;
  final String name;
  final String description;
  final double price;
  final int stockQuantity;
  final String categoryId;
  final String image;
  const Product({
    required this.productId,
    required this.name,
    required this.description,
    required this.price,
    required this.stockQuantity,
    required this.categoryId,
    required this.image,
  });

  Product copyWith({
    int? productId,
    String? name,
    String? description,
    double? price,
    int? stockQuantity,
    String? categoryId,
    String? image,
  }) {
    return Product(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      categoryId: categoryId ?? this.categoryId,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'name': name,
      'description': description,
      'price': price,
      'stockQuantity': stockQuantity,
      'categoryId': categoryId,
      'images': image,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productId: map['productId'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as double,
      stockQuantity: map['stockQuantity'] as int,
      categoryId: map['categoryId'] as String,
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      productId,
      name,
      description,
      price,
      stockQuantity,
      categoryId,
      image,
    ];
  }
}
