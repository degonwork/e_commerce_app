import 'package:e_commerce_app_getx/data/models/product_model.dart';
import 'package:e_commerce_app_getx/data/responsitory/cart_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/cart_model.dart';
import '../ui/utils/colors.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  Map<int, Cart> _items = {};
  Map<int, Cart> get items => _items;

  void addItem(Product product, int quantity) {
    num totalQuantity = 0;
    if (_items.containsKey(product.id)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return Cart(
          id: value.id,
          title: value.title,
          price: value.price,
          image: value.image,
          quantity: value.quantity! + quantity,
          isExit: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });
      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          return Cart(
            id: product.id,
            title: product.title,
            price: product.price,
            image: product.image,
            quantity: quantity,
            isExit: true,
            time: DateTime.now().toString(),
            product: product,
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
    update();
  }

  bool isExitInCart(Product product) {
    if (_items.containsKey(product.id)) {
      return true;
    } else {
      return false;
    }
  }

  int getQuantity(Product product) {
    int quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    int totalItems = 0;
    _items.forEach((key, value) {
      totalItems += value.quantity!;
    });
    return totalItems;
  }

  List<Cart> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  num get totalAmount {
    num total = 0;
    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }
}
