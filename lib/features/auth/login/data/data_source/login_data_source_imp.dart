import 'package:ecommerce_app_huma_volve/features/auth/login/data/data_source/login_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/models/login_model.dart';

import '../../../../../core/constant/api_end_point.dart';
import '../../../../../core/network_service/network_services.dart';

class LoginDataSourceImp implements LoginDataSource {
  final NetworkServices networkServices;

  LoginDataSourceImp(this.networkServices);

  @override
  Future<LoginModel> login(String email, String password) async {
    final response = await networkServices.dio.post(
      ApiEndPoint.login,
      data: {'email': email, 'password': password},
    );
    final jsonResponse = response.data;
    final loginModel = LoginModel.fromJson(jsonResponse);
    return loginModel;
  }
}
