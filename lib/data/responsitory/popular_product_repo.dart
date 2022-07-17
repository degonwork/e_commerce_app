import 'package:e_commerce_app_getx/data/api/api_client.dart';
import 'package:e_commerce_app_getx/utils/app_constants.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});
  Future getProductList() async {
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URL);
  }
}
