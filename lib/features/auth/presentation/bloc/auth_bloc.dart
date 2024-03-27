import 'package:ecommerce/core/common/no_params.dart';
import 'package:ecommerce/core/cubit/user_cubit.dart';
import 'package:ecommerce/features/auth/domain/usecases/get_current_user.dart';
import 'package:ecommerce/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/features/auth/domain/entities/user_entity.dart';
import 'package:ecommerce/features/auth/domain/usecases/google_sign_in.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GoogleSignInUsecase _googleSignInusecase;
  final GetCurrentUser _getCurrentUser;
  final SignOutUsecase _signOutUsecase;
  final UserCubit _userCubit;

  AuthBloc({
    required GoogleSignInUsecase googleSignInUsecase,
    required UserCubit userCubit,
    required GetCurrentUser getCurrentUser,
    required SignOutUsecase signOutUsecase,
  })  : _googleSignInusecase = googleSignInUsecase,
        _userCubit = userCubit,
        _getCurrentUser = getCurrentUser,
        _signOutUsecase = signOutUsecase,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      emit(AuthLoading());
      if (event is AuthSignIn) {
        final res = await _googleSignInusecase(NoParams());
        res.fold(
          (l) => emit(AuthFailure(error: l)),
          (r) {
            _userCubit.updateUser(r);
            emit(AuthSuccess(user: r));
          },
        );
      } else if (event is AuthIsSignIn) {
        final res = await _getCurrentUser(NoParams());
        res.fold(
          (l) => emit(AuthInitial()),
          (r) {
            _userCubit.updateUser(r);
            emit(AuthSuccess(user: r));
          },
        );
      } else if (event is AuthSignOut) {
        final res = await _signOutUsecase(NoParams());
        res.fold((l) => null, (r) {
          _userCubit.emit(UserInitial());
          emit(AuthInitial());
        });
      }
    });
  }
}
