
import '../models/Signup_res_model.dart';
import '../models/signup_req_model.dart';

abstract class SignupDataSource {

  Future<SignupResModel> signup(SignupReqModel signupReqModel);
}
