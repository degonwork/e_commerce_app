import 'package:e_commerce_app_getx/controllers/order_controller.dart';
import 'package:e_commerce_app_getx/data/models/order_model.dart';
import 'package:e_commerce_app_getx/ui/pages/widgets/custom_loader.dart';
import 'package:e_commerce_app_getx/ui/utils/colors.dart';
import 'package:e_commerce_app_getx/ui/utils/dimension.dart';
import 'package:e_commerce_app_getx/ui/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class ViewOrder extends StatelessWidget {
  final bool isCurrent;
  const ViewOrder({super.key, required this.isCurrent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderController>(
        builder: (orderController) {
          if (orderController.isLoading == false) {
            late List<Order> orderList;
            if (orderController.historyOrderList.isNotEmpty) {
              orderList = isCurrent
                  ? orderController.currentOrderList.reversed.toList()
                  : orderController.historyOrderList.reversed.toList();
            }
            return SizedBox(
              width: Dimensions.screenWidth,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width10 / 2,
                    vertical: Dimensions.height10 / 2),
                child: ListView.builder(
                    itemCount: orderList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => null,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'order ID',
                                    style: robotoRegular.copyWith(
                                      fontSize: Dimensions.font12,
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.width10 / 2),
                                  Text('#${orderList[index].id.toString()}'),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.mainColor,
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius20 / 4),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Dimensions.width10,
                                            vertical: Dimensions.width10 / 2),
                                        child: !isCurrent
                                            ? Text(
                                                "Confirmed",
                                                style: robotoMedium.copyWith(
                                                  fontSize: Dimensions.font12,
                                                  color: Theme.of(context)
                                                      .cardColor,
                                                ),
                                              )
                                            : Text(
                                                "Pending",
                                                style: robotoMedium.copyWith(
                                                  fontSize: Dimensions.font12,
                                                  color: Theme.of(context)
                                                      .cardColor,
                                                ),
                                              ),
                                      )),
                                  SizedBox(height: Dimensions.height10 / 2),
                                  InkWell(
                                    onTap: () => null,
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Dimensions.width10,
                                            vertical: Dimensions.width10 / 2),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius20 / 4),
                                          border: Border.all(
                                              width: 1,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                                "assets/image/tracking.png",
                                                height: 15,
                                                width: 15,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            SizedBox(
                                                width: Dimensions.width10 / 2),
                                            Text(
                                              "Track order",
                                              style: robotoMedium.copyWith(
                                                fontSize: Dimensions.font12,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(height: Dimensions.height10),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            );
          } else {
            return CustomLoader();
          }
        },
      ),
    );
  }
}
