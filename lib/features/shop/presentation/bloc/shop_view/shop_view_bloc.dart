import 'package:ecommerce/core/common/no_params.dart';
import 'package:ecommerce/features/shop/domain/usecases/get_all_products_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/features/shop/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

part 'shop_view_event.dart';
part 'shop_view_state.dart';

class ShopViewBloc extends Bloc<ShopViewEvent, ShopViewState> {
  final GetAllProductsUsecase _getAllProductsUsecase;

  ShopViewBloc({
    required GetAllProductsUsecase getAllProductsUsecase,
  })  : _getAllProductsUsecase = getAllProductsUsecase,
        super(ShopViewInitial()) {
    on<ShopViewEvent>((event, emit) async {
      emit(ShopViewLoading());
      if (event is ShopViewLoad) {
        final res = await _getAllProductsUsecase(NoParams());
        res.fold(
          (l) => emit(ShopViewFailure(error: l)),
          (r) => emit(ShopViewSuccess(products: r)),
        );
      }
    });
  }
}
