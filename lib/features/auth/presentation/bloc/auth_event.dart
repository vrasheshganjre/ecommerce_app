part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthSignIn extends AuthEvent {}

class AuthIsSignIn extends AuthEvent {}

class AuthSignOut extends AuthEvent {}
