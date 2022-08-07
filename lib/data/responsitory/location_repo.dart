import 'package:dio/dio.dart';
import 'package:e_commerce_app_getx/data/provider/api_client.dart';
import 'package:e_commerce_app_getx/data/provider/api_google_map.dart';
import 'package:e_commerce_app_getx/ui/utils/app_constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepo {
  final ApiGoogleMap apiGoogleMap;
  final SharedPreferences sharedPreferences;
  LocationRepo({required this.apiGoogleMap, required this.sharedPreferences});

  Future<Response> getAddressfromGeocode(
      LatLng origin, LatLng destination) async {
    return await apiGoogleMap.getAddress(origin, destination);
  }

  String getUserAddress() {
    return sharedPreferences.getString(AppConstants.USER_ADDRESS) ?? '';
  }
}
