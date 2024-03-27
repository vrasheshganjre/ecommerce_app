part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartLoad extends CartEvent {
  final String uid;

  const CartLoad({required this.uid});
}

class CartAdd extends CartEvent {
  final String uid;
  final int productId;
  final int quantity;

  const CartAdd(
      {required this.uid, required this.productId, required this.quantity});
}

class CartRemove extends CartEvent {
  final String uid;
  final int productId;

  const CartRemove({required this.uid, required this.productId});
}
