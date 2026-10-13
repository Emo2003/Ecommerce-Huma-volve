import 'package:dart_either/src/dart_either.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/error/error_handling.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/core/storage_services/secure_storage.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/data_source/login_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/login_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/repository/login_repo.dart';

class LoginRepoImp implements LoginRepository {
  final LoginDataSource loginDataSource;

  LoginRepoImp(this.loginDataSource);

  @override
  Future<Either<Failure, LoginEntity>> login(
    String email,
    String password,
  ) async {
    try {
      final loginResponse = await loginDataSource.login(email, password);
      await SecureStorage.saveAccessToken(loginResponse.accessToken ?? '');
      await SecureStorage.saveRefreshToken(loginResponse.refreshToken ?? '');
      return Right(loginResponse);
    } on DioException catch (e) {
      return Left(ErrorHandling.handleError(e));
    } catch (e) {
      return Left(Failure(message: "Something went wrong: ${e.toString()}"));
    }
  }
}
