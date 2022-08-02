import 'package:e_commerce_app_getx/data/models/respone_model.dart';
import 'package:e_commerce_app_getx/data/responsitory/auth_repo.dart';
import 'package:get/get.dart';
import '../data/models/signup_body_model.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    Response response = await authRepo.registration(signUpBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserName(response.body['id'].toString());
      responseModel = ResponseModel(true, response.body['id'].toString());
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = true;
    update();
    return responseModel;
  }
}
