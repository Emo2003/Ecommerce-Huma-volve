import 'package:dart_either/dart_either.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/repository/login_repo.dart';

import '../../../../../core/failure/failure.dart';
import '../entities/login_entity.dart';

class LoginUseCase {
  LoginRepository loginRepository;

  LoginUseCase(this.loginRepository);

  Future<Either<Failure, LoginEntity>> call(
    String email,
    String password,
  ) async {
    return await loginRepository.login(email, password);
  }
}
