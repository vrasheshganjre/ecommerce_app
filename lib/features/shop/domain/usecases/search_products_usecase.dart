// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';

import 'package:ecommerce/features/shop/domain/entities/product.dart';
import 'package:ecommerce/features/shop/domain/repository/shop_repository.dart';

class SearchProductsUsecase {
  final ShopRepository shopRepository;
  SearchProductsUsecase({
    required this.shopRepository,
  });
  Future<Either<String, List<Product>>> call(
      SearchProductsParams params) async {
    return shopRepository.searchProducts(params.query);
  }
}

class SearchProductsParams {
  final String query;
  SearchProductsParams({
    required this.query,
  });
}
