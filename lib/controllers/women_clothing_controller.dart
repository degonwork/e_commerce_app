import 'dart:convert';
import 'package:e_commerce_app_getx/data/models/product_model.dart';
import 'package:get/get.dart';
import '../data/responsitory/women_clothing_repo.dart';

class WomenClothingController extends GetxController {
  final WomenClothingRepo womenClothingRepo;
  WomenClothingController({required this.womenClothingRepo});
  List<Product> _productList = [];
  List<Product> get productList => _productList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getWomenClothingList() async {
    Response response = await womenClothingRepo.getWomenClothingList();
    if (response.statusCode == 200) {
      print('got women clothing');
      List<dynamic> result = jsonDecode(jsonEncode(response.body));
      _productList = [];
      for (var element in result) {
        _productList.add(Product.fromJson(element));
      }
      _isLoaded = true;
      update();
    } else {
      print('error');
    }
  }
}
