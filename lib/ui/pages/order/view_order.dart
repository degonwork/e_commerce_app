import 'package:e_commerce_app_getx/controllers/order_controller.dart';
import 'package:e_commerce_app_getx/data/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class ViewOrder extends StatelessWidget {
  final bool isCurrent;
  const ViewOrder({super.key, required this.isCurrent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<OrderController>(
      builder: (orderController) {
        if (orderController.isLoading == false) {
          late List<Order> orderList;
          if (orderController.historyOrderList.isNotEmpty) {
            orderList = isCurrent
                ? orderController.currentOrderList.reversed.toList()
                : orderController.historyOrderList.reversed.toList();
          }
          return Text(orderList.length.toString());
        } else {
          return Text('Loading');
        }
      },
    ));
  }
}
