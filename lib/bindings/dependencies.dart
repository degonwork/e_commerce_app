import 'package:e_commerce_app_getx/controllers/auth_controller.dart';
import 'package:e_commerce_app_getx/controllers/electronics_controller.dart';
import 'package:e_commerce_app_getx/controllers/user_controller.dart';
import 'package:e_commerce_app_getx/data/responsitory/auth_repo.dart';
import 'package:e_commerce_app_getx/data/responsitory/electronics_repo.dart';
import 'package:e_commerce_app_getx/data/responsitory/user_repo.dart';
import 'package:e_commerce_app_getx/data/responsitory/women_clothing_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/cart_controller.dart';
import '../controllers/women_clothing_controller.dart';
import '../data/provider/api_client.dart';
import '../data/responsitory/cart_repo.dart';
import '../ui/utils/app_constants.dart';

Future<void> init() async {
  // shared preference
  final sharedPreference = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreference);

  // api
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  // repo
  Get.lazyPut(
      () => UserRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => AuthRepo(
        apiClient: Get.find(),
        sharedPreferences: Get.find(),
      ));
  Get.lazyPut(() => ElectronicsRepo(apiClient: Get.find()));
  Get.lazyPut(() => WomenClothingRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  // controller
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => ElectronicsController(electronicsRepo: Get.find()));
  Get.lazyPut(() => WomenClothingController(womenClothingRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
