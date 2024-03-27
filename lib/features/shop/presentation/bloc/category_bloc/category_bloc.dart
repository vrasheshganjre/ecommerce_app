import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/features/shop/domain/entities/product.dart';
import 'package:ecommerce/features/shop/domain/usecases/get_products_by_category_usecase.dart';
import 'package:equatable/equatable.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetProductsByCategoryUsecase _getProductsByCategoryUsecase;

  CategoryBloc(
      {required GetProductsByCategoryUsecase getProductsByCategoryUsecase})
      : _getProductsByCategoryUsecase = getProductsByCategoryUsecase,
        super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) async {
      emit(CategoryLoading());
      if (event is CategoryLoad) {
        final res = await _getProductsByCategoryUsecase(
          GetProductsByCategoryParams(
            category: event.categoryId,
          ),
        );
        res.fold(
          (l) => emit(CategoryError(error: l)),
          (r) => emit(CategorySuccess(products: r)),
        );
      }
    });
  }
}
