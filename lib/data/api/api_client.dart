import 'package:e_commerce_app_getx/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiClient extends GetConnect implements GetxService {
  late String token;
  late String appBaseUrl;
  late Map<String, String> _mainHeader = {};
  ApiClient({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30);
    token = AppConstants.TOKEN;
    _mainHeader = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }
  Future<Response> getData(String uri) async {
    // var client = http.Client();
    try {
      // final response = await client.get(Uri.parse(uri));
      Response response = await get(uri);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
