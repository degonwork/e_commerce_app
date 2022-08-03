import 'package:e_commerce_app_getx/data/models/user_model.dart';
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

  Future<Response> registration(User signUpBody) async {
    return await apiClient.postData(AppConstants.USER_URL, signUpBody.toJson());
  }

  Future<Response> login(String username, String password) async {
    return await apiClient.postData(
        AppConstants.LOGIN_URL, {"username": username, "password": password});
  }

  Future<bool> saveUserName(String id) async {
    return await sharedPreferences.setString(AppConstants.IDUSER, id);
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "None";
  }

  Future<void> saveUserNameAndPassword(String username, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.USERNAME, username);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    } catch (e) {
      throw e;
    }
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.USERNAME);
    sharedPreferences.remove(AppConstants.PASSWORD);
    apiClient.token = '';
    apiClient.updateHeader('');
    return true;
  }
}
