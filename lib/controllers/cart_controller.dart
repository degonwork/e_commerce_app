import 'dart:convert';

import 'package:e_commerce_app_getx/data/models/product_model.dart';
import 'package:e_commerce_app_getx/data/responsitory/cart_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../data/models/cart_model.dart';
import '../ui/utils/colors.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  Map<int, Cart> _items = {};
  Map<int, Cart> get items => _items;
  List<Cart> storageItem = [];

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
    cartRepo.addToCartList(getItems);
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

  List<Cart> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItem;
  }

  set setCart(List<Cart> items) {
    storageItem = items;
    for (int i = 0; i < storageItem.length; i++) {
      _items.putIfAbsent(storageItem[i].product!.id!, () => storageItem[i]);
    }
  }

  void addToHistory() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  Map<String, int> getcartItemsPerOrder() {
    Map<String, int> cartItemsPerOrder = Map();

    for (int i = 0; i < getCartHistoryList().length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList()[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList()[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList()[i].time!, () => 1);
      }
    }
    return cartItemsPerOrder;
  }

  List<int> cartItemsPerOrderToList() {
    return getcartItemsPerOrder().entries.map((e) => e.value).toList();
  }

  List<String> cartOrderTimeToList() {
    return getcartItemsPerOrder().entries.map((e) => e.key).toList();
  }

  void clear() {
    _items = {};
    update();
  }

  List<Cart> getCartHistoryList() {
    return cartRepo.getCartHistoryList().toList();
  }

  void getMoreOrder(int index) {
    var orderTime = cartOrderTimeToList();
    Map<int, Cart> moreOrder = {};
    for (int j = 0; j < getCartHistoryList().length; j++) {
      if (getCartHistoryList()[j].time == orderTime[index]) {
        moreOrder.putIfAbsent(
            getCartHistoryList()[j].id!,
            () =>
                Cart.fromJson(jsonDecode(jsonEncode(getCartHistoryList()[j]))));
      }
    }
    setItems = moreOrder;
    addToCartList();
  }

  set setItems(Map<int, Cart> setItems) {
    _items = {};
    _items = setItems;
  }

  void addToCartList() {
    cartRepo.addToCartList(getItems);
    update();
  }

  void clearCarthistory() {
    cartRepo.clearCartHistory();
    update();
  }

  String getDateTime(listCounter) {
    var outPutDate = DateTime.now().toString();
    if (listCounter < getCartHistoryList().length) {
      DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
          .parse(getCartHistoryList()[listCounter].time.toString());
      var inputDate = DateTime.parse(parseDate.toString());
      var outPutFormat = DateFormat("MM/dd/yyyy hh:mm a");
      outPutDate = outPutFormat.format(inputDate);
    }
    return outPutDate;
  }
}
