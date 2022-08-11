import 'dart:convert';
import 'dart:math';
import 'package:e_commerce_app_getx/data/models/user_model.dart';
import 'package:e_commerce_app_getx/data/responsitory/location_repo.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../data/models/address_maps_model.dart';

class LocationController extends GetxController implements GetxService {
  final LocationRepo locationRepo;
  LocationController({required this.locationRepo});
  bool _loading = false;
  late Position _position;
  late Position _pickPosition;
  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();
  Placemark get placemark => _placemark;
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
  bool _changeAddress = true;
  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  Future<void> updatePosition(
      LatLng origin, CameraPosition position, bool fromAddress) async {
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
        if (_changeAddress) {
          String _address = await getAddressfromGeocode(origin,
              LatLng(position.target.latitude, position.target.longitude));
          fromAddress
              ? _placemark = Placemark(name: _address)
              : _pickPlacemark = Placemark(name: _address);
        }
      } catch (e) {
        print(e);
      }
      _loading = false;
      update();
    }
  }

  Future<String> getAddressfromGeocode(
      LatLng origin, LatLng destinatrion) async {
    String _address = "Unknown Location Found";
    final response =
        await locationRepo.getAddressfromGeocode(origin, destinatrion);
    if (response.statusCode == 200) {
      _address = response.data['routes'][0]['legs'][0]['end_address'];
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
    final response = await locationRepo.getAllAndressList();
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
}
