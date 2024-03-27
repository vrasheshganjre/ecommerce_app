import 'package:ecommerce/features/shop/domain/entities/product.dart';

class Cart {
  final String userId;
  final Map<Product, int> products;

  Cart({required this.userId, required this.products});
}
