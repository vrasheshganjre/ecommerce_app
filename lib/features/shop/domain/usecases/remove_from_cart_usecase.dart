import 'package:ecommerce/features/shop/domain/repository/shop_repository.dart';
import 'package:fpdart/fpdart.dart';

class RemoveFromCartUsecase {
  final ShopRepository shopRepository;

  RemoveFromCartUsecase({required this.shopRepository});
  Future<Either<String, void>> call(RemoveFromCartParams params) {
    return shopRepository.removeFromCart(params.uid, params.productId);
  }
}

class RemoveFromCartParams {
  final String uid;
  final int productId;

  RemoveFromCartParams({required this.uid, required this.productId});
}
