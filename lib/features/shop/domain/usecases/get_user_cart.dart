// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';

import 'package:ecommerce/features/shop/domain/entities/cart.dart';
import 'package:ecommerce/features/shop/domain/repository/shop_repository.dart';

class GetUserCartUsecase {
  final ShopRepository shopRepository;
  GetUserCartUsecase({
    required this.shopRepository,
  });
  Future<Either<String, Cart>> call(GetUserCartParams params) {
    return shopRepository.getCart(params.uid);
  }
}

class GetUserCartParams {
  final String uid;
  GetUserCartParams({
    required this.uid,
  });
}
