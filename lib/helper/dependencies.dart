import 'package:e_commerce_app_getx/controllers/electronics_controller.dart';
import 'package:e_commerce_app_getx/data/api/api_client.dart';
import 'package:e_commerce_app_getx/data/responsitory/popular_product_repo.dart';
import 'package:e_commerce_app_getx/utils/app_constants.dart';
import 'package:get/get.dart';

Future<void> init() async {
  // api
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //repo
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));

  // controller
  Get.lazyPut(() => ElectronicsController(popularProductRepo: Get.find()));
}
