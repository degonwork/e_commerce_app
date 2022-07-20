import 'dart:convert';

import 'package:e_commerce_app_getx/data/responsitory/electronics_repo.dart';
import 'package:get/get.dart';

import '../data/models/electronics_model.dart';

class ElectronicsController extends GetxController {
  final ElectronicsRepo elctronicsRepo;
  ElectronicsController({required this.elctronicsRepo});
  List<Electronics> _electronicsList = [];
  List<Electronics> get electronicsList => _electronicsList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getElectronicsList() async {
    Response response = await elctronicsRepo.getElectronicsList();
    if (response.statusCode == 200) {
      print('got electronics');
      List<dynamic> result = jsonDecode(jsonEncode(response.body));
      _electronicsList = [];
      for (var element in result) {
        _electronicsList
            .add(Electronics.fromJson(Map<String, dynamic>.from(element)));
      }
      _isLoaded = true;
      update();
    } else {
      print('error');
    }
    // print(_popularProductList);
  }
}
