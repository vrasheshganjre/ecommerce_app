import 'package:fpdart/fpdart.dart';

import 'package:ecommerce/features/shop/domain/entities/product.dart';
import 'package:ecommerce/features/shop/domain/repository/shop_repository.dart';

class GetAllProductsUsecase<Params> {
  final ShopRepository shopRepository;
  GetAllProductsUsecase({
    required this.shopRepository,
  });
  Future<Either<String, List<Product>>> call(Params params) async {
    return shopRepository.getAllProducts();
  }
}
