import 'dart:convert';
import 'dart:math';
import 'package:e_commerce_app_getx/data/models/respone_model.dart';
import 'package:e_commerce_app_getx/data/models/user_model.dart';
import 'package:e_commerce_app_getx/data/provider/api_checker.dart';
import 'package:e_commerce_app_getx/data/responsitory/location_repo.dart';
import 'package:e_commerce_app_getx/ui/utils/dimension.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../data/models/address_maps_model.dart';
import 'package:google_maps_webservice/src/places.dart';

class LocationController extends GetxController implements GetxService {
  final LocationRepo locationRepo;
  LocationController({required this.locationRepo});
  bool _loading = false;
  late Position _position;
  late Position _pickPosition;

  Placemark _placemark = Placemark();
  Placemark get placemark => _placemark;

  Placemark _pickPlacemark = Placemark();
  Placemark get pickPlacemark => _pickPlacemark;

  List<AddressMaps> _addressList = [];
  List<AddressMaps> get addressList => _addressList;

  late List<AddressMaps> _allAddressList;
  List<AddressMaps> get allAddressList => _allAddressList;

  List<String> _addressTypeList = ["home", "office", "others"];
  List<String> get addressTypeList => _addressTypeList;

  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;

  late Map<String, dynamic> _getAddress;
  Map<String, dynamic> get getAddress => _getAddress;

  late GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;

  bool _updateAddressData = true;
  bool get updateAddressData => _updateAddressData;

  bool _changeAddress = true;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _inZone = false;
  bool get inZone => _inZone;

  bool _buttonDisable = true;
  bool get buttonDisable => _buttonDisable;

  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;

  List<Prediction> _predictionList = [];

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  Future<void> updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updateAddressData) {
      _loading = true;
      update();
      try {
        if (fromAddress) {
          _position = Position(
            longitude: position.target.longitude,
            latitude: position.target.latitude,
            timestamp: DateTime.now(),
            accuracy: 1,
            altitude: 1,
            heading: 1,
            speed: 1,
            speedAccuracy: 1,
          );
        } else {
          _pickPosition = Position(
            longitude: position.target.longitude,
            latitude: position.target.latitude,
            timestamp: DateTime.now(),
            accuracy: 1,
            altitude: 1,
            heading: 1,
            speed: 1,
            speedAccuracy: 1,
          );
        }
        ResponseModel _responseModel = await getZone(
            position.target.latitude.toString(),
            position.target.longitude.toString(),
            false);
        _buttonDisable = !_responseModel.isSuccess;
        if (_changeAddress) {
          String _address = await getAddressfromGeocode(
              LatLng(position.target.latitude, position.target.longitude));
          fromAddress
              ? _placemark = Placemark(name: _address)
              : _pickPlacemark = Placemark(name: _address);
        } else {
          _changeAddress = true;
          update();
        }
      } catch (e) {
        print(e);
      }
      _loading = false;
      update();
    } else {
      _updateAddressData = true;
      update();
    }
  }

  Future<String> getAddressfromGeocode(LatLng latLng) async {
    String _address = "Unknown Location Found";
    Response response = await locationRepo.getAddressfromGeocode(latLng);
    if (response.statusCode == 200 && response.body['status'] == 'OK') {
      _address = response.body['results'][0]['formatted_address'].toString();
    } else {
      print("Error getting the google api");
    }
    update();
    return _address;
  }

  AddressMaps getUserAddress() {
    late AddressMaps _addressModel;
    _getAddress = jsonDecode(locationRepo.getUserAddress());
    try {
      _addressModel = AddressMaps.fromJson(_getAddress);
    } catch (e) {
      print(e);
    }
    return _addressModel;
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  Future<void> addAddress(AddressMaps addressMaps) async {
    _loading = true;
    update();
    // function addAdress from locationRepo
    await getAddressList();
    await saveUserAddress(addressMaps);
  }

  Future<void> getAddressList() async {
    Response response = await locationRepo.getAllAddressList();
    if (response.statusCode == 200) {
      _addressList = [];
      _allAddressList = [];
      List<dynamic> result = jsonDecode(jsonEncode(response.body));
      for (var element in result) {
        _addressList.add(
          AddressMaps(
              addressType: _addressTypeList[Random().nextInt(3)],
              contactPersonName: '${User.fromJson(element).name!.firstname}'
                  ' ${User.fromJson(element).name!.lastname}',
              contactPersonNumber: '${User.fromJson(element).phone}',
              address: '${User.fromJson(element).address!.street}'
                  ','
                  ' ${User.fromJson(element).address!.city}',
              latitude: '${User.fromJson(element).address!.geolocation!.lat}',
              longitude:
                  '${User.fromJson(element).address!.geolocation!.long}'),
        );
        _allAddressList.add(
          AddressMaps(
              addressType: _addressTypeList[Random().nextInt(3)],
              contactPersonName: '${User.fromJson(element).name!.firstname}'
                  ' ${User.fromJson(element).name!.lastname}',
              contactPersonNumber: '${User.fromJson(element).phone}',
              address: '${User.fromJson(element).address!.street}'
                  ','
                  ' ${User.fromJson(element).address!.city}',
              latitude: '${User.fromJson(element).address!.geolocation!.lat}',
              longitude:
                  '${User.fromJson(element).address!.geolocation!.long}'),
        );
      }
    } else {
      _addressList = [];
      _allAddressList = [];
    }
    update();
  }

  Future saveUserAddress(AddressMaps addressMaps) async {
    String userAddress = jsonEncode(addressMaps);
    print("My Address in my view: " + userAddress.toString());
    return await locationRepo.saveUserAddress(userAddress);
  }

  void clearAddressList() {
    _addressList = [];
    _allAddressList = [];
    update();
  }

  String getUserFromLocalStorage() {
    return locationRepo.getUserAddress();
  }

  void setAddAddressData() {
    _position = _pickPosition;
    _placemark = _pickPlacemark;
    _updateAddressData = false;
    update();
  }

  Future<ResponseModel> getZone(String lat, String lng, bool markerLoad) async {
    late ResponseModel _responseModel;
    if (markerLoad) {
      _loading = true;
    } else {
      _isLoading = true;
    }
    update();
    // Check zone with server
    await Future.delayed(const Duration(seconds: 2), () {
      _responseModel = ResponseModel(true, "Success");
      if (markerLoad) {
        _loading = false;
      } else {
        _isLoading = false;
      }
      _inZone = true;
    });
    update();
    return _responseModel;
  }

  // Search Location
  Future<List<Prediction>> searchLocation(
      BuildContext context, String text) async {
    if (text.isNotEmpty) {
      Response response = await locationRepo.searchLocation(text);
      if (response.statusCode == 200 && response.body['status'] == 'OK') {
        _predictionList = [];
        List<dynamic> results =
            jsonDecode(jsonEncode(response.body))['predictions'];
        for (var element in results) {
          _predictionList.add(Prediction.fromJson(element));
        }
      } else {
        ApiChecker.checkApi(response);
      }
    }
    return _predictionList;
  }

  Future<void> setLocation(String placeId, String address,
      GoogleMapController? mapController) async {
    _loading = true;
    update();
    PlacesDetailsResponse detail;
    Response response = await locationRepo.setLocation(placeId);
    detail =
        PlacesDetailsResponse.fromJson(jsonDecode(jsonEncode(response.body)));
    _pickPosition = Position(
      latitude: detail.result.geometry!.location.lat,
      longitude: detail.result.geometry!.location.lng,
      timestamp: DateTime.now(),
      accuracy: 1,
      heading: 1,
      altitude: 1,
      speedAccuracy: 1,
      speed: 1,
    );
    _pickPlacemark = Placemark(name: address);
    _changeAddress = false;
    if (mapController != null) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(
                detail.result.geometry!.location.lat,
                detail.result.geometry!.location.lng,
              ),
              zoom: Dimensions.width10 * 1.7),
        ),
      );
    }
    _loading = false;
    update();
  }
}
