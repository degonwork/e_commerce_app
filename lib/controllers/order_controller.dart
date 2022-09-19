import 'dart:convert';
import 'package:e_commerce_app_getx/controllers/cart_controller.dart';
import 'package:e_commerce_app_getx/data/models/cart_model.dart';
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
    Response response = await orderRepo.getOrderList();
    if (response.statusCode == 200) {
      print('get order list');
      _historyOrderList = [];
      List<dynamic> results = jsonDecode(jsonEncode(response.body));
      for (var element in results) {
        _historyOrderList.add(Order.fromJson(element));
      }
    } else {
      _historyOrderList = [];
    }
    _isLoading = false;
    update();
  }

  Future<int?> addOrder(Order order) async {
    _isLoading = true;
    update();
    Response response = await orderRepo.postOrder(order);
    late int? id;
    if (response.statusCode == 200) {
      id = response.body['id'];
    } else {
      id = null;
    }
    _isLoading = false;
    update();
    return id;
  }

  void getListOrder(List<int> listKey) async {
    List<String> orderString = [];
    int? id;
    List<Order> addOrderList = orderRepo.getListOrder(listKey);
    for (int i = 0; i < addOrderList.length; i++) {
      id = await addOrder(addOrderList[i]);
      orderString.add(orderRepo.addToOrderList(addOrderList[i], id));
    }
    for (int i = 0; i < getCurrentOrderList().length; i++) {
      orderString.add(jsonEncode(getCurrentOrderList()[i]));
    }
    orderRepo.addOrderStorage(orderString);
    update();
  }

  List<Order> getCurrentOrderList() {
    _currentOrderList = orderRepo.getOrder();
    update();
    return _currentOrderList;
  }
}
