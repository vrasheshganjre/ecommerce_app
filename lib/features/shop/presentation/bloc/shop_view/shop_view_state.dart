part of 'shop_view_bloc.dart';

sealed class ShopViewState extends Equatable {
  const ShopViewState();

  @override
  List<Object> get props => [];
}

final class ShopViewInitial extends ShopViewState {}

final class ShopViewLoading extends ShopViewState {}

final class ShopViewFailure extends ShopViewState {
  final String error;

  const ShopViewFailure({required this.error});
}

final class ShopViewSuccess extends ShopViewState {
  final List<Product> products;

  const ShopViewSuccess({required this.products});
}
