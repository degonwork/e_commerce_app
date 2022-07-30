import 'package:e_commerce_app_getx/controllers/cart_controller.dart';
import 'package:e_commerce_app_getx/ui/pages/widgets/app_icon.dart';
import 'package:e_commerce_app_getx/ui/pages/widgets/big_text.dart';
import 'package:e_commerce_app_getx/ui/utils/colors.dart';
import 'package:e_commerce_app_getx/ui/utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartHistory extends StatefulWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  State<CartHistory> createState() => _CartHistoryState();
}

class _CartHistoryState extends State<CartHistory> {
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartItemsPerOrder();
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: 45, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Cart History", color: Colors.white),
                AppIcon(
                  icon: Icons.shopping_cart,
                  iconColor: AppColors.mainColor,
                ),
              ],
            ),
          ),
          GetBuilder<CartController>(
            builder: (cartController) {
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    top: Dimensions.width20,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  child: ListView(
                    children: [
                      for (int i = 0;
                          i < cartController.itemsPerOrder.length;
                          i++)
                        Container(
                          margin: EdgeInsets.only(bottom: Dimensions.height20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: '05/02/2021'),
                              Row(
                                children: [
                                  Wrap(
                                      direction: Axis.horizontal,
                                      children: List.generate(
                                          cartController.itemsPerOrder[i],
                                          (index) {
                                        if (cartController.listCounter <
                                            cartController
                                                .getCartHistoryList()
                                                .length) {
                                          cartController.listCounter++;
                                        }
                                        return Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                cartController
                                                    .getCartHistoryList()[
                                                        cartController
                                                                .listCounter -
                                                            1]
                                                    .image!,
                                              ),
                                            ),
                                          ),
                                        );
                                      }))
                                ],
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
