
import 'package:e_commerce_app_getx/data/models/signup_body_model.dart';
import 'package:e_commerce_app_getx/data/provider/api_client.dart';
import 'package:e_commerce_app_getx/ui/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClient.postData(
        AppConstants.REGISTRATION_URL, signUpBody.toJson());
  }

  Future<bool> saveUserName(String id) async {
    return await sharedPreferences.setString(AppConstants.IDUSER, id);
  }
}
