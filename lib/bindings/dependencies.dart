import 'package:e_commerce_app_getx/controllers/electronics_controller.dart';
import 'package:e_commerce_app_getx/data/responsitory/electronics_repo.dart';
import 'package:e_commerce_app_getx/data/responsitory/women_clothing_repo.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../controllers/women_clothing_controller.dart';
import '../data/provider/api_client.dart';
import '../data/responsitory/cart_repo.dart';
import '../ui/utils/app_constants.dart';

Future<void> init() async {
  // api
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //repo
  Get.lazyPut(() => ElectronicsRepo(apiClient: Get.find()));
  Get.lazyPut(() => WomenClothingRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo());

  // controller
  Get.lazyPut(() => ElectronicsController(elctronicsRepo: Get.find()));
  Get.lazyPut(() => WomenClothingController(womenClothingRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
