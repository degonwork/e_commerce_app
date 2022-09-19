import 'dart:convert';

import 'package:e_commerce_app_getx/data/models/order_model.dart';
import 'package:e_commerce_app_getx/data/provider/api_client.dart';
import 'package:e_commerce_app_getx/ui/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/user_controller.dart';
import '../../ui/pages/widgets/show_custom_snackbar.dart';
import '../models/cart_model.dart';

class OrderRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  OrderRepo({required this.apiClient, required this.sharedPreferences});

  List<String> order = [];

  Future<Response> getOrderList() async {
    return await apiClient.getData(AppConstants.ORDER_LIST_URL);
  }

  Future<Response> postOrder(Order order) async {
    return await apiClient.postData(
        AppConstants.ORDER_LIST_URL, order.toJson());
  }

  List<Map<int, Cart>> getMoreCart(List<int> listKey) {
    var orderTime = Get.find<CartController>().cartOrderTimeToList();
    List<Map<int, Cart>> listCart = [];
    Map<int, Cart> moreCart = {};
    if (listKey.isEmpty) {
      showCustomSnackbar("Please add your Cart", title: "Your Cart is Empty");
    } else {
      for (int i = 0; i < listKey.length; i++) {
        for (int j = 0;
            j < Get.find<CartController>().getCartHistoryList().length;
            j++) {
          if (Get.find<CartController>().getCartHistoryList()[j].time ==
              orderTime[listKey[i]]) {
            moreCart.putIfAbsent(
                Get.find<CartController>().getCartHistoryList()[j].id!,
                () => Cart.fromJson(jsonDecode(jsonEncode(
                    Get.find<CartController>().getCartHistoryList()[j]))));
          }
        }
        listCart.add(moreCart);
        moreCart = {};
      }
    }
    return listCart;
  }

  List<Order> getListOrder(List<int> listKey) {
    List<Map<int, Cart>> listCart = getMoreCart(listKey);
    List<Order> listOrder = [];
    for (int i = 0; i < listCart.length; i++) {
      listOrder.add(Order(
          userId: Get.find<UserController>().getUser()!.id,
          date: formatDate(listCart[i]),
          products: listCart[i]
              .entries
              .map((e) => Product(productId: e.key, quantity: e.value.quantity))
              .toList()
              .reversed
              .toList()));
    }
    return listOrder;
  }

  DateTime formatDate(Map<int, Cart> date) {
    DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm:ss")
        .parse(date.values.first.time.toString());
    return dateTime;
  }

  String addToOrderList(Order order, int? id) {
    Map<String, dynamic> orderMap = jsonDecode(jsonEncode(order));
    orderMap["id"] = id;
    Order orderCurrent = Order.fromJson(orderMap);
    String orderString = jsonEncode(orderCurrent);
    return orderString;
  }

  void addOrderStorage(List<String> orderString) {
    sharedPreferences.setStringList(AppConstants.ORDER_LIST, orderString);
  }

  List<Order> getOrder() {
    List<Order> orderList = [];
    if (sharedPreferences.containsKey(AppConstants.ORDER_LIST)) {
      order = [];
      order = sharedPreferences.getStringList(AppConstants.ORDER_LIST)!;
    }
    order.forEach(
        (element) => orderList.add(Order.fromJson(jsonDecode(element))));
    return orderList;
  }
}
