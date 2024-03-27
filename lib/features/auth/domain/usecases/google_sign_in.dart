import 'package:ecommerce/features/auth/domain/entities/user_entity.dart';
import 'package:ecommerce/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class GoogleSignInUsecase<NoParams> {
  final AuthRepository authRepository;

  GoogleSignInUsecase({required this.authRepository});
  Future<Either<String, UserEntity>> call(NoParams params) async {
    return await authRepository.googleSignIn();
  }
}
