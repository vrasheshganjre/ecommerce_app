import 'package:ecommerce/features/auth/domain/entities/user_entity.dart';
import 'package:ecommerce/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCurrentUser<NoParams> {
  final AuthRepository authRepository;

  GetCurrentUser({required this.authRepository});
  Future<Either<String, UserEntity>> call(NoParams params) {
    return authRepository.currentUser();
  }
}
