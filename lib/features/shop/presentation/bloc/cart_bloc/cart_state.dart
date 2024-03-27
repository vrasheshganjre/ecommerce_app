part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

final class CartError extends CartState {
  final String error;

  const CartError({required this.error});
}

final class CartLoaded extends CartState {
  final Cart cart;

  const CartLoaded({required this.cart});
}

final class CartLoading extends CartState {}
