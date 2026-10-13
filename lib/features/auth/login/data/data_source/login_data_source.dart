import 'package:ecommerce_app_huma_volve/features/auth/login/data/models/login_model.dart';

abstract class LoginDataSource {
  Future<LoginModel> login(String email, String password);
}
