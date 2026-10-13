import 'package:dart_either/src/dart_either.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/error/error_handling.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/data_source/signup_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/entities/signup_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/repository/signup_repo.dart';

import '../models/signup_req_model.dart';

class SignupRepoImp implements SignupRepo {
  final SignupDataSource signupDataSource;

  SignupRepoImp(this.signupDataSource);

  @override
  Future<Either<Failure, SignupEntity>> signup(
    SignupReqModel signupReqModel,
  ) async {
    try {
      final result = await signupDataSource.signup(signupReqModel);
      return Right(result);
    } on DioException catch (e) {
      return Left(ErrorHandling.handleError(e));
    } catch (e) {
      return Left(
        Failure(message: "An unexpected error occurred: ${e.toString()}"),
      );
    }
  }
}
