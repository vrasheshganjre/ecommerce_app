import 'package:ecommerce/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:ecommerce/features/auth/domain/entities/user_entity.dart';
import 'package:ecommerce/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl({required this.authRemoteDatasource});
  @override
  Future<Either<String, UserEntity>> googleSignIn() async {
    try {
      return right(await authRemoteDatasource.signInWithGoogle());
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, UserEntity>> currentUser() async {
    try {
      final user = await authRemoteDatasource.getCurrentUser();
      if (user != null) {
        return right(user);
      }
      return left("User not logged in");
    } catch (e) {
      return left("User not logged in");
    }
  }

  @override
  Future<Either<String, void>> signOut() async {
    try {
      return right(await authRemoteDatasource.signOut());
    } catch (e) {
      return left(e.toString());
    }
  }
}
