import 'package:e_commerce_app_getx/data/provider/api_client.dart';
import 'package:get/get.dart';

import '../../ui/utils/app_constants.dart';

class WomenClothingRepo extends GetxService {
  final ApiClient apiClient;
  WomenClothingRepo({required this.apiClient});
  Future getWomenClothingList() async {
    return await apiClient.getData(AppConstants.WOMEN_CLOTHING_URL);
  }
}
