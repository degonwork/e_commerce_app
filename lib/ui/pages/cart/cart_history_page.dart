import 'package:e_commerce_app_getx/controllers/cart_controller.dart';
import 'package:e_commerce_app_getx/controllers/order_controller.dart';
import 'package:e_commerce_app_getx/ui/pages/widgets/no_data_page.dart';
import 'package:e_commerce_app_getx/ui/pages/widgets/app_icon.dart';
import 'package:e_commerce_app_getx/ui/pages/widgets/big_text.dart';
import 'package:e_commerce_app_getx/ui/pages/widgets/show_custom_snackbar.dart';
import 'package:e_commerce_app_getx/ui/pages/widgets/small_text.dart';
import 'package:e_commerce_app_getx/ui/utils/colors.dart';
import 'package:e_commerce_app_getx/ui/utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/route_helper.dart';

class CartHistoryPage extends StatefulWidget {
  const CartHistoryPage({Key? key}) : super(key: key);

  @override
  State<CartHistoryPage> createState() => _CartHistoryPageState();
}

class _CartHistoryPageState extends State<CartHistoryPage> {
  bool changeTheme = false;
  final List<int> listKey = [];
  void tapChange() {
    setState(() {
      changeTheme = !changeTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    int listCounter = 0;
    var getCartHistoryList = Get.find<CartController>().getCartHistoryList();
    List<int> itemsPerOrder =
        Get.find<CartController>().cartItemsPerOrderToList();
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(
                top: Dimensions.height45, bottom: Dimensions.height15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Cart History", color: Colors.white),
                Row(
                  children: [
                    AppIcon(
                      icon: Icons.shopping_cart,
                      iconColor: AppColors.mainColor,
                    ),
                    SizedBox(width: Dimensions.width45),
                    GestureDetector(
                      onTap: tapChange,
                      child: AppIcon(
                        icon: Icons.check_outlined,
                        iconColor: AppColors.mainColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (cartController) {
            return getCartHistoryList.length > 0
                ? Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: Dimensions.width20,
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                      ),
                      child: MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: changeTheme
                            ? ListView(
                                children: [
                                  for (int i = 0; i < itemsPerOrder.length; i++)
                                    buildListview(listCounter, itemsPerOrder,
                                        getCartHistoryList, i),
                                ],
                              )
                            : ListView(
                                children: [
                                  for (int i = 0; i < itemsPerOrder.length; i++)
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: Dimensions.height20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          BigText(
                                            text: Get.find<CartController>()
                                                .getDateTime(listCounter),
                                          ),
                                          SizedBox(height: Dimensions.height10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Wrap(
                                                direction: Axis.horizontal,
                                                children: List.generate(
                                                  itemsPerOrder[i],
                                                  (index) {
                                                    if (listCounter <
                                                        getCartHistoryList
                                                            .length) {
                                                      listCounter++;
                                                    }
                                                    return index <= 2
                                                        ? Container(
                                                            height: Dimensions
                                                                    .width20 *
                                                                4,
                                                            width: Dimensions
                                                                    .width20 *
                                                                4,
                                                            margin: EdgeInsets.only(
                                                                right: Dimensions
                                                                        .width10 /
                                                                    2),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          Dimensions.width15 /
                                                                              2),
                                                              image:
                                                                  DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image:
                                                                    NetworkImage(
                                                                  getCartHistoryList[
                                                                          listCounter -
                                                                              1]
                                                                      .image!,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : Container();
                                                  },
                                                ),
                                              ),
                                              Container(
                                                height: Dimensions.width30 * 4,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    SmallText(
                                                      text: "Total",
                                                      color:
                                                          AppColors.titleColor,
                                                    ),
                                                    BigText(
                                                      text: itemsPerOrder[i]
                                                              .toString() +
                                                          ' Items',
                                                      color:
                                                          AppColors.titleColor,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.find<
                                                                CartController>()
                                                            .getMoreOrder(i);
                                                        Get.toNamed(RouteHelper
                                                            .getcartPage());
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal:
                                                                Dimensions
                                                                    .width10,
                                                            vertical: Dimensions
                                                                    .height10 /
                                                                2),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                            .radius15 /
                                                                        3),
                                                            border: Border.all(
                                                                width: 1,
                                                                color: AppColors
                                                                    .mainColor)),
                                                        child: SmallText(
                                                            text: 'one more',
                                                            color: AppColors
                                                                .mainColor),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                      ),
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: Center(
                      child: NoDataPage(
                        text: "You didn't buy anything so far !",
                        imgPath: 'assets/image/empty_box.png',
                      ),
                    ),
                  );
          }),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          top: Dimensions.height20,
          bottom: Dimensions.height20,
          right: Dimensions.height45 * 2,
          left: Dimensions.height45 * 2,
        ),
        decoration: BoxDecoration(color: AppColors.buttonBackgroundColor),
        child: GestureDetector(
          onTap: () {
            if (changeTheme == false) {
              showCustomSnackbar("Please check your Cart",
                  title: "You don't check your Cart");
            } else {
              Get.find<OrderController>().getListOrder(listKey);
              Get.find<CartController>().clearCarthistory();
              setState(() {
                changeTheme = false;
              });
            }
          },
          child: Container(
              padding: EdgeInsets.only(
                top: Dimensions.height20,
                bottom: Dimensions.height20,
                right: Dimensions.height20,
                left: Dimensions.height20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: AppColors.mainColor,
              ),
              child: BigText(text: 'Payment orders', color: Colors.white)),
        ),
      ),
    );
  }

  Widget buildListview(
    listCounter,
    itemsPerOrder,
    getCartHistoryList,
    i,
  ) {
    bool _isContainKey = listKey.contains(i);
    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.height20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(
            text: Get.find<CartController>().getDateTime(listCounter),
          ),
          SizedBox(height: Dimensions.height10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (_isContainKey) {
                      listKey.remove(i);
                    } else {
                      listKey.add(i);
                    }
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width10,
                      vertical: Dimensions.height10),
                  child: _isContainKey
                      ? Icon(
                          Icons.check_box,
                          color: Colors.brown,
                        )
                      : Icon(
                          Icons.check_box_outline_blank,
                          color: Colors.brown,
                        ),
                ),
              ),
              Wrap(
                direction: Axis.horizontal,
                children: List.generate(
                  itemsPerOrder[i],
                  (index) {
                    if (listCounter < getCartHistoryList.length) {
                      listCounter++;
                    }
                    return index <= 2
                        ? Container(
                            height: Dimensions.width20 * 4,
                            width: Dimensions.width20 * 4,
                            margin:
                                EdgeInsets.only(right: Dimensions.width10 / 2),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.width15 / 2),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  getCartHistoryList[listCounter - 1].image!,
                                ),
                              ),
                            ),
                          )
                        : Container();
                  },
                ),
              ),
              Container(
                height: Dimensions.width30 * 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SmallText(
                      text: "Total",
                      color: AppColors.titleColor,
                    ),
                    BigText(
                      text: itemsPerOrder[i].toString() + ' Items',
                      color: AppColors.titleColor,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.find<CartController>().getMoreOrder(i);
                        Get.toNamed(RouteHelper.getcartPage());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width10,
                            vertical: Dimensions.height10 / 2),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius15 / 3),
                            border: Border.all(
                                width: 1, color: AppColors.mainColor)),
                        child: SmallText(
                            text: 'one more', color: AppColors.mainColor),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
