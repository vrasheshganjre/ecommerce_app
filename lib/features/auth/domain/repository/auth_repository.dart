import 'package:ecommerce/features/auth/domain/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<String, UserEntity>> googleSignIn();
  Future<Either<String, UserEntity>> currentUser();
  Future<Either<String, void>> signOut();
}
