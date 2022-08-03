import 'package:e_commerce_app_getx/data/models/respone_model.dart';
import 'package:e_commerce_app_getx/data/responsitory/auth_repo.dart';
import 'package:get/get.dart';
import '../data/models/user_model.dart';

class AuthController extends GetxController {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(User signUpBody) async {
    _isLoading = true;
    update();
    Response response = await authRepo.registration(signUpBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserName(response.body['id'].toString());
      responseModel = ResponseModel(true, response.body['id'].toString());
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String username, String password) async {
    _isLoading = true;
    update();
    Response response = await authRepo.login(username, password);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body['token']);
      saveUserNameAndPassword(username, password);
      responseModel = ResponseModel(true, response.body['token']);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void saveUserNameAndPassword(String username, String password) {
    authRepo.saveUserNameAndPassword(username, password);
  }

  bool userLoggedIn() {
    return authRepo.userLoggedIn();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }
}
