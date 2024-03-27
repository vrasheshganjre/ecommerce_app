import 'package:ecommerce/features/shop/domain/repository/shop_repository.dart';
import 'package:fpdart/fpdart.dart';

class AddToCartUsecase {
  final ShopRepository shopRepository;

  AddToCartUsecase({required this.shopRepository});
  Future<Either<String, void>> call(AddToCartParams params) {
    return shopRepository.addToCart(
        params.uid, params.productId, params.quantity);
  }
}

class AddToCartParams {
  final String uid;
  final int productId;
  final int quantity;

  AddToCartParams(
      {required this.uid, required this.productId, required this.quantity});
}
