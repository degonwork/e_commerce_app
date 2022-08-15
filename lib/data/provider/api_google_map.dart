import 'package:e_commerce_app_getx/ui/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ApiGoogleMap extends GetConnect implements GetxService {
  final String appBaseUrl;
  late Map<String, String>? _mainHeader = {};
  ApiGoogleMap({
    required this.appBaseUrl,
  }) {
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30);
  }
  Future<Response> getAddress(
    String uri,
    LatLng latLng,
  ) async {
    try {
      Response response = await get(uri, query: {
        'latlng': '${latLng.latitude}, ${latLng.longitude}',
        'key': AppConstants.GOOGLE_API_KEY
      });
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getSearchLocation(
    String uri,
    String text,
  ) async {
    try {
      Response response = await get(uri,
          query: {'input': '$text', 'key': AppConstants.GOOGLE_API_KEY});
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> setLocation(
    String uri,
    String placeId,
  ) async {
    try {
      Response response = await get(uri,
          query: {'placeid': '$placeId', 'key': AppConstants.GOOGLE_API_KEY});
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
