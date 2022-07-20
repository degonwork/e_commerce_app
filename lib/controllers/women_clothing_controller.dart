import 'dart:convert';
import 'package:get/get.dart';
import '../data/models/electronics_model.dart';
import '../data/responsitory/women_clothing_repo.dart';

class WomenClothingController extends GetxController {
  final WomenClothingRepo womenClothingRepo;
  WomenClothingController({required this.womenClothingRepo});
  List<Electronics> _womenClothingList = [];
  List<Electronics> get electronicsList => _womenClothingList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getWomenClothingList() async {
    Response response = await womenClothingRepo.getWomenClothingList();
    if (response.statusCode == 200) {
      print('got women clothing');
      List<dynamic> result = jsonDecode(jsonEncode(response.body));
      _womenClothingList = [];
      for (var element in result) {
        _womenClothingList
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
