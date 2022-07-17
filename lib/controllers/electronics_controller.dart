import 'dart:convert';

import 'package:e_commerce_app_getx/data/responsitory/popular_product_repo.dart';
import 'package:e_commerce_app_getx/models/electronics_model.dart';
import 'package:get/get.dart';

class ElectronicsController extends GetxController {
  final PopularProductRepo popularProductRepo;
  ElectronicsController({required this.popularProductRepo});
  List<Electronics> _electronicsList = [];
  List<Electronics> get electronicsList => _electronicsList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getProductList();
    if (response.statusCode == 200) {
      print('got product');
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
