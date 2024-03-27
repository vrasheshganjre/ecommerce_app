import 'package:ecommerce/features/shop/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel(
      {required super.productId,
      required super.name,
      required super.description,
      required super.price,
      required super.stockQuantity,
      required super.categoryId,
      required super.image});

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'name': name,
      'description': description,
      'price': price,
      'stockQuantity': stockQuantity,
      'categoryId': categoryId,
      'image': image,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['product_id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as double,
      stockQuantity: map['stock_quantity'] as int,
      categoryId: map['category'] as String,
      image: map['image'],
    );
  }
}
