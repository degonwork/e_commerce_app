import 'package:dio/dio.dart';
import 'package:e_commerce_app_getx/ui/utils/app_constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ApiGoogleMap {
  final Dio dio;
  late Map<String, String?> queryParameters;
  ApiGoogleMap({required this.dio});
  Future<Response> getAddress(LatLng origin, LatLng destination) async {
    try {
      Response response =
          await dio.get(AppConstants.BASE_GOOGLE_MAPS_URL, queryParameters: {
        'origin': '${origin.latitude}, ${origin.longitude}',
        'destination': '${destination.latitude}, ${destination.longitude}',
        'key': AppConstants.GOOGLE_API_KEY
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
