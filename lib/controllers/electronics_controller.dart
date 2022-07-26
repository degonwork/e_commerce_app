import 'dart:convert';
import 'package:e_commerce_app_getx/controllers/cart_controller.dart';
import 'package:e_commerce_app_getx/data/responsitory/electronics_repo.dart';
import 'package:e_commerce_app_getx/ui/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/cart_model.dart';
import '../data/models/product_model.dart';

class ElectronicsController extends GetxController {
  final ElectronicsRepo elctronicsRepo;
  ElectronicsController({required this.elctronicsRepo});
  List<Product> _electronicsList = [];
  List<Product> get electronicsList => _electronicsList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItem = 0;
  int get inCartItem => _inCartItem + _quantity;
  late CartController _cart;

  Future<void> getElectronicsList() async {
    Response response = await elctronicsRepo.getElectronicsList();
    if (response.statusCode == 200) {
      print('got electronics');
      List<dynamic> result = jsonDecode(jsonEncode(response.body));
      _electronicsList = [];
      for (var element in result) {
        _electronicsList.add(Product.fromJson(element));
      }
      _isLoaded = true;
      update();
    } else {
      print('error');
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItem + quantity) < 0) {
      Get.snackbar(
        'Item count',
        "you can't reduce more",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      if (_inCartItem > 0) {
        _quantity = -_inCartItem;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItem + quantity) > 20) {
      Get.snackbar(
        'Item count',
        "you can't add more",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
    }
    return quantity;
  }

  void initProduct(Product product, CartController cart) {
    _quantity = 0;
    _inCartItem = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.isExitInCart(product);
    if (exist) {
      _inCartItem = cart.getQuantity(product);
    }
  }

  void addItem(Product product) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItem = _cart.getQuantity(product);
    _cart.items.forEach((key, value) {
      print("id: " +
          value.id.toString() +
          " quantity " +
          value.quantity.toString());
    });
    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<Cart> get getItems {
    return _cart.getItems;
  }
}
