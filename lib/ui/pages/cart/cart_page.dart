import 'package:e_commerce_app_getx/controllers/auth_controller.dart';
import 'package:e_commerce_app_getx/controllers/cart_controller.dart';
import 'package:e_commerce_app_getx/controllers/electronics_controller.dart';
import 'package:e_commerce_app_getx/controllers/location_controller.dart';
import 'package:e_commerce_app_getx/controllers/user_controller.dart';
import 'package:e_commerce_app_getx/controllers/women_clothing_controller.dart';
import 'package:e_commerce_app_getx/ui/pages/widgets/app_icon.dart';
import 'package:e_commerce_app_getx/ui/pages/widgets/big_text.dart';
import 'package:e_commerce_app_getx/ui/pages/widgets/small_text.dart';
import 'package:e_commerce_app_getx/ui/utils/colors.dart';
import 'package:e_commerce_app_getx/ui/utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/route_helper.dart';
import '../widgets/no_data_page.dart';

class Cartpage extends StatelessWidget {
  const Cartpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: Dimensions.height20 * 3,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                  SizedBox(width: Dimensions.width20 * 5),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitialPage());
                    },
                    child: AppIcon(
                      icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ],
              ),
            ),
            GetBuilder<CartController>(builder: (cartController) {
              return cartController.getItems.length > 0
                  ? Positioned(
                      top: Dimensions.height20 * 5,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: 0,
                      child: Container(
                        margin: EdgeInsets.only(top: Dimensions.height15),
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: GetBuilder<CartController>(
                            builder: (cartController) {
                              var _cartList = cartController.getItems;
                              return ListView.builder(
                                itemCount: _cartList.length,
                                itemBuilder: ((context, index) {
                                  return Container(
                                    width: double.maxFinite,
                                    height: Dimensions.height20 * 5,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            var electronicsIndex = Get.find<
                                                    ElectronicsController>()
                                                .electronicsList
                                                .indexOf(
                                                    _cartList[index].product!);
                                            if (electronicsIndex >= 0) {
                                              Get.toNamed(RouteHelper
                                                  .getElectronicsPage(
                                                      electronicsIndex,
                                                      'cartpage'));
                                            } else {
                                              var womenClothingIndex = Get.find<
                                                      WomenClothingController>()
                                                  .womenClothingList
                                                  .indexOf(_cartList[index]
                                                      .product!);
                                              if (womenClothingIndex < 0) {
                                                Get.snackbar(
                                                  'History product',
                                                  "Product review is not available for history products",
                                                  backgroundColor:
                                                      AppColors.mainColor,
                                                  colorText: Colors.white,
                                                );
                                              } else {
                                                Get.toNamed(RouteHelper
                                                    .getWomenClothingPage(
                                                        womenClothingIndex,
                                                        "cartpage"));
                                              }
                                            }
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                bottom: Dimensions.height10),
                                            width: Dimensions.height20 * 5,
                                            height: Dimensions.height20 * 5,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    cartController
                                                        .getItems[index]
                                                        .image!),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius20),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: Dimensions.width10),
                                        Expanded(
                                          child: Container(
                                            height: Dimensions.height20 * 5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                BigText(
                                                  text: cartController
                                                      .getItems[index].title!,
                                                  color: Colors.black54,
                                                ),
                                                SmallText(text: "Spicy"),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    BigText(
                                                        text:
                                                            "\$ ${cartController.getItems[index].price}",
                                                        color:
                                                            Colors.redAccent),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                        top:
                                                            Dimensions.height10,
                                                        bottom:
                                                            Dimensions.height10,
                                                        left:
                                                            Dimensions.width10,
                                                        right:
                                                            Dimensions.width10,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                Dimensions
                                                                    .radius20),
                                                        color: Colors.white,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          GestureDetector(
                                                              onTap: () {
                                                                cartController.addItem(
                                                                    _cartList[
                                                                            index]
                                                                        .product!,
                                                                    -1);
                                                              },
                                                              child: Icon(
                                                                  Icons.remove,
                                                                  color: AppColors
                                                                      .signColor)),
                                                          SizedBox(
                                                              width: Dimensions
                                                                      .width10 /
                                                                  2),
                                                          BigText(
                                                              text: _cartList[
                                                                      index]
                                                                  .quantity
                                                                  .toString()),
                                                          SizedBox(
                                                              width: Dimensions
                                                                      .width10 /
                                                                  2),
                                                          GestureDetector(
                                                            onTap: (() {
                                                              cartController.addItem(
                                                                  _cartList[
                                                                          index]
                                                                      .product!,
                                                                  1);
                                                            }),
                                                            child: Icon(
                                                                Icons.add,
                                                                color: AppColors
                                                                    .signColor),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  : NoDataPage(text: 'Your cart is empty!');
            })
          ],
        ),
        bottomNavigationBar: GetBuilder<CartController>(
          builder: (cartController) {
            return Container(
                height: Dimensions.bottomHeightBar,
                padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  bottom: Dimensions.height20,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                ),
                decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20 * 2),
                    topRight: Radius.circular(Dimensions.radius20 * 2),
                  ),
                ),
                child: cartController.getItems.length > 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              top: Dimensions.height20,
                              bottom: Dimensions.height20,
                              left: Dimensions.width20,
                              right: Dimensions.width20,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: Dimensions.width10 / 2),
                                BigText(
                                    text: "\$ " +
                                        cartController.totalAmount
                                            .toStringAsFixed(2)),
                                SizedBox(width: Dimensions.width10 / 2),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (Get.find<AuthController>().userLoggedIn()) {
                                if (Get.find<LocationController>()
                                    .addressList
                                    .isEmpty) {
                                  Get.toNamed(RouteHelper.getAddAddressPage());
                                } else {
                                  // Get.offNamed(RouteHelper.getInitialPage());
                                  // Get.offNamed(RouteHelper.getPaymentPage(
                                  //     '100127',
                                  //     Get.find<UserController>().user!.id!));
                                }
                              } else {
                                Get.toNamed(RouteHelper.getSignInPage());
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                top: Dimensions.height20,
                                bottom: Dimensions.height20,
                                left: Dimensions.width20,
                                right: Dimensions.width20,
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                color: AppColors.mainColor,
                              ),
                              child: BigText(
                                  text: 'Check out', color: Colors.white),
                            ),
                          )
                        ],
                      )
                    : Container());
          },
        ));
  }
}
