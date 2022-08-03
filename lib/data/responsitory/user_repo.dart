import 'package:e_commerce_app_getx/data/provider/api_client.dart';
import 'package:e_commerce_app_getx/ui/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  UserRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstants.USER_URL);
  }

  String getUsername() {
    return sharedPreferences.getString(AppConstants.USERNAME) ?? "None";
  }

  String getPassword() {
    return sharedPreferences.getString(AppConstants.PASSWORD) ?? "None";
  }
}
