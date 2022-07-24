import 'package:e_commerce_app_getx/data/models/electronics_model.dart';
import 'package:e_commerce_app_getx/data/responsitory/cart_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import '../data/models/cart_model.dart';
import '../ui/utils/colors.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  Map<int, Cart> _items = {};
  Map<int, Cart> get items => _items;

  void addItem(Electronics electronics, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(electronics.id)) {
      _items.update(electronics.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return Cart(
          id: value.id,
          title: value.title,
          price: value.price,
          image: value.image,
          quantity: value.quantity! + quantity,
          isExit: true,
          time: DateTime.now().toString(),
        );
      });
      if (totalQuantity <= 0) {
        _items.remove(electronics.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(electronics.id!, () {
          return Cart(
            id: electronics.id,
            title: electronics.title,
            price: electronics.price,
            image: electronics.image,
            quantity: quantity,
            isExit: true,
            time: DateTime.now().toString(),
          );
        });
      } else {
        Get.snackbar(
          'Item count',
          "you should at least add an item in the cart",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
        );
      }
    }
  }

  bool isExitInCart(Electronics electronics) {
    if (_items.containsKey(electronics.id)) {
      return true;
    } else {
      return false;
    }
  }

  int getQuantity(Electronics electronics) {
    var quantity = 0;
    if (_items.containsKey(electronics.id)) {
      _items.forEach((key, value) {
        if (key == electronics.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }
}
