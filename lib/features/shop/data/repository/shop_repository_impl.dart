import 'package:ecommerce/features/shop/data/datasource/shop_remote_data_source.dart';
import 'package:ecommerce/features/shop/domain/entities/cart.dart';
import 'package:ecommerce/features/shop/domain/entities/product.dart';
import 'package:ecommerce/features/shop/domain/repository/shop_repository.dart';
import 'package:fpdart/fpdart.dart';

class ShopRepositoryImpl implements ShopRepository {
  final ShopRemoteDatasource shopRemoteDatasource;

  ShopRepositoryImpl({required this.shopRemoteDatasource});
  @override
  Future<Either<String, List<Product>>> getAllProducts() async {
    try {
      return right(await shopRemoteDatasource.getAllProducts());
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<Product>>> getProductsByCategory(
      String category) async {
    try {
      return right(await shopRemoteDatasource.getProductsbyCategory(category));
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<Product>>> searchProducts(String query) async {
    try {
      return right(await shopRemoteDatasource.searchProducts(query));
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, Cart>> getCart(String uid) async {
    try {
      return right(await shopRemoteDatasource.getCart(uid));
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> addToCart(
      String uid, int productId, int quantity) async {
    try {
      return right(
          await shopRemoteDatasource.addToCart(productId, uid, quantity));
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> removeFromCart(String uid, int productId) async {
    try {
      return right(await shopRemoteDatasource.removeFromCart(productId, uid));
    } catch (e) {
      return left(e.toString());
    }
  }
}
