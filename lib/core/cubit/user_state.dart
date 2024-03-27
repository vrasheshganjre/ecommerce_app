part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoggedIn extends UserState {
  final UserEntity user;

  const UserLoggedIn({required this.user});
}
