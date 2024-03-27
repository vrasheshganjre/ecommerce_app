import 'package:ecommerce/features/shop/domain/usecases/search_products_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/features/shop/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchProductsUsecase _searchProductsUsecase;

  SearchBloc({required SearchProductsUsecase searchProductsUsecase})
      : _searchProductsUsecase = searchProductsUsecase,
        super(SearchInitial()) {
    on<SearchEvent>((event, emit) async {
      emit(SearchLoading());
      if (event is SearchStart) {
        if (event.query.isEmpty) {
          emit(SearchInitial());
        } else {
          final res = await _searchProductsUsecase(
              SearchProductsParams(query: event.query));
          res.fold(
            (l) => emit(SearchError(error: l)),
            (r) => emit(SearchSuccess(products: r)),
          );
        }
      }
    });
  }
}
