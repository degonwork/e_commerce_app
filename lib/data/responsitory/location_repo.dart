import 'package:e_commerce_app_getx/data/provider/api_client.dart';
import 'package:e_commerce_app_getx/data/provider/api_google_map.dart';
import 'package:e_commerce_app_getx/ui/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepo {
  final ApiGoogleMap apiGoogleMap;
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;
  LocationRepo(
      {required this.apiGoogleMap,
      required this.apiClient,
      required this.sharedPreferences});

  Future<Response> getAddressfromGeocode(LatLng latLng) async {
    return await apiGoogleMap.getAddress(AppConstants.GOOGLE_MAPS_URL, latLng);
  }

  String getUserAddress() {
    return sharedPreferences.getString(AppConstants.USER_ADDRESS) ?? '';
  }

  // add andress function

  Future getAllAddressList() async {
    return await apiClient.getData(AppConstants.USER_URL);
  }

  Future<bool> saveUserAddress(String userAddress) async {
    apiClient.updateHeader(sharedPreferences.getString(AppConstants.TOKEN)!);
    return await sharedPreferences.setString(
        AppConstants.USER_ADDRESS, userAddress);
  }

  // Get zone

  // Search Location
  Future<Response> searchLocation(String text) async {
    return await apiGoogleMap.getSearchLocation(
        AppConstants.SEARCH_LOCATION_URL, text);
  }

  Future<Response> setLocation(String placeId) async {
    return await apiGoogleMap.setLocation(
        AppConstants.PLACE_DETAILS_URL, placeId);
  }
}
