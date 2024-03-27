import 'package:ecommerce/core/common/no_params.dart';
import 'package:ecommerce/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignOutUsecase {
  final AuthRepository authRepository;

  SignOutUsecase({required this.authRepository});
  Future<Either<String, void>> call(NoParams params) {
    return authRepository.signOut();
  }
}
