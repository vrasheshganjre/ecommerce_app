part of 'shop_view_bloc.dart';

sealed class ShopViewEvent extends Equatable {
  const ShopViewEvent();

  @override
  List<Object> get props => [];
}

class ShopViewLoad extends ShopViewEvent {}
