import 'package:e_commerce_app_getx/data/provider/api_client.dart';
import 'package:get/get.dart';

import '../../ui/utils/app_constants.dart';

class ElectronicsRepo extends GetxService {
  final ApiClient apiClient;
  ElectronicsRepo({required this.apiClient});
  Future getElectronicsList() async {
    return await apiClient.getData(AppConstants.ELECTRONICS_URL);
  }
}
