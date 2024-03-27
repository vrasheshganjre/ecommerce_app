import 'package:ecommerce/features/shop/domain/entities/cart.dart';
import 'package:ecommerce/features/shop/domain/entities/product.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ShopRepository {
  Future<Either<String, List<Product>>> getAllProducts();
  Future<Either<String, List<Product>>> getProductsByCategory(String category);
  Future<Either<String, List<Product>>> searchProducts(String query);
  Future<Either<String, Cart>> getCart(String uid);
  Future<Either<String, void>> addToCart(
      String uid, int productId, int quantity);
  Future<Either<String, void>> removeFromCart(String uid, int productId);
}
