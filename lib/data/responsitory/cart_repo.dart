import 'dart:convert';

import 'package:e_commerce_app_getx/ui/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_model.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  void addToCartList(List<Cart> cartList) {
    cart = [];
    cartList.forEach((element) => cart.add(jsonEncode(element)));
    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    getCartList();
  }

  List<Cart> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
    }
    List<Cart> cartList = [];
    carts
        .forEach((element) => cartList.add(Cart.fromJson(jsonDecode(element))));
    return cartList;
  }
}
