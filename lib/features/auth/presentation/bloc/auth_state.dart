part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthSuccess extends AuthState {
  final UserEntity user;

  const AuthSuccess({required this.user});
}

final class AuthFailure extends AuthState {
  final String error;

  const AuthFailure({required this.error});
}

final class AuthLoading extends AuthState {}
