import 'dart:convert';
import 'package:e_commerce_app_getx/ui/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_model.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<Cart> cartList) {
    var time = DateTime.now().toString();
    cart = [];
    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });
    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
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

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      cart = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
    }
    for (int i = 0; i < cart.length; i++) {
      cartHistory.add(cart[i]);
    }

    removeCart();
    sharedPreferences.setStringList(
        AppConstants.CART_HISTORY_LIST, cartHistory);
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

  List<Cart> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    cartHistory = cartHistory.reversed.toList();
    List<Cart> cartHistoryList = [];
    cartHistory.forEach(
        (element) => cartHistoryList.add(Cart.fromJson(jsonDecode(element))));
    return cartHistoryList;
  }
}
