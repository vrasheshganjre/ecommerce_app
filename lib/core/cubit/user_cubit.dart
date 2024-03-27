import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/features/auth/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void updateUser(UserEntity user) {
    emit(UserLoggedIn(user: user));
  }
}
