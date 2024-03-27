// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';

import 'package:ecommerce/features/shop/domain/entities/product.dart';
import 'package:ecommerce/features/shop/domain/repository/shop_repository.dart';

class GetProductsByCategoryUsecase {
  final ShopRepository shopRepository;
  GetProductsByCategoryUsecase({
    required this.shopRepository,
  });
  Future<Either<String, List<Product>>> call(
      GetProductsByCategoryParams params) async {
    return shopRepository.getProductsByCategory(params.category);
  }
}

class GetProductsByCategoryParams {
  final String category;
  GetProductsByCategoryParams({
    required this.category,
  });
}
