import 'package:ecommerce/core/cubit/user_cubit.dart';
import 'package:ecommerce/features/shop/domain/usecases/add_to_cart_usecase.dart';
import 'package:ecommerce/features/shop/domain/usecases/get_user_cart.dart';
import 'package:ecommerce/features/shop/domain/usecases/remove_from_cart_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/features/shop/domain/entities/cart.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetUserCartUsecase _getUserCartUsecase;
  final AddToCartUsecase _addToCartUsecase;
  final RemoveFromCartUsecase _removeFromCartUsecase;
  final UserCubit _userCubit;
  late Cart userCart;

  CartBloc({
    required GetUserCartUsecase getUserCartUsecase,
    required AddToCartUsecase addToCartUsecase,
    required RemoveFromCartUsecase removeFromCartUsecase,
    required UserCubit userCubit,
  })  : _getUserCartUsecase = getUserCartUsecase,
        _addToCartUsecase = addToCartUsecase,
        _removeFromCartUsecase = removeFromCartUsecase,
        _userCubit = userCubit,
        super(CartInitial()) {
    on<CartEvent>((event, emit) async {
      emit(CartLoading());
      if (event is CartLoad) {
        final res =
            await _getUserCartUsecase(GetUserCartParams(uid: event.uid));
        res.fold(
          (l) {
            emit(CartError(error: l));
          },
          (r) {
            userCart = r;
            emit(CartLoaded(cart: r));
          },
        );
      } else if (event is CartAdd) {
        final res = await _addToCartUsecase(
          AddToCartParams(
              uid: event.uid,
              productId: event.productId,
              quantity: event.quantity),
        );
        res.fold(
          (l) => null,
          (r) {
            add(
              CartLoad(uid: event.uid),
            );
          },
        );
      } else if (event is CartRemove) {
        final res = await _removeFromCartUsecase(
          RemoveFromCartParams(
            uid: event.uid,
            productId: event.productId,
          ),
        );
        res.fold(
          (l) => Fluttertoast.showToast(msg: l),
          (r) {
            add(
              CartLoad(uid: event.uid),
            );
          },
        );
      }
    });
  }
}
