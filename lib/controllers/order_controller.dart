import 'dart:convert';

import 'package:e_commerce_app_getx/data/models/order_model.dart';
import 'package:e_commerce_app_getx/data/responsitory/order_repo.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final OrderRepo orderRepo;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  late List<Order> _currentOrderList;
  late List<Order> _historyOrderList;

  List<Order> get currentOrderList => _currentOrderList;
  List<Order> get historyOrderList => _historyOrderList;

  OrderController({required this.orderRepo});

  Future<void> getOrderList() async {
    _isLoading = true;
    update();
    Response response = await orderRepo.getOrderList();
    if (response.statusCode == 200) {
      _currentOrderList = [];
      _historyOrderList = [];

      List<dynamic> results = jsonDecode(jsonEncode(response.body));
      for (var element in results) {
        _historyOrderList.add(Order.fromJson(element));
      }
    } else {
      _currentOrderList = [];
      _historyOrderList = [];
    }
    _isLoading = false;
    update();
  }
}
