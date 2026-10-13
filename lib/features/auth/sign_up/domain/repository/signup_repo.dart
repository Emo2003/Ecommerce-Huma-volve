import 'package:dart_either/dart_either.dart';

import '../../../../../core/failure/failure.dart';
import '../../data/models/signup_req_model.dart';
import '../entities/signup_entity.dart';

abstract class SignupRepo {
  Future<Either<Failure, SignupEntity>> signup(SignupReqModel signupReqModel);
}
