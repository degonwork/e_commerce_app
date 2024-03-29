import 'package:e_commerce_app_getx/controllers/cart_controller.dart';
import 'package:e_commerce_app_getx/controllers/electronics_controller.dart';
import 'package:e_commerce_app_getx/routes/route_helper.dart';
import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/dimension.dart';
import '../widgets/app_column.dart';
import '../widgets/app_icon.dart';
import '../widgets/big_text.dart';
import '../widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

class ElectronicsPageDetail extends StatelessWidget {
  const ElectronicsPageDetail({
    Key? key,
    required this.pageId,
    required this.page,
  }) : super(key: key);
  final int? pageId;
  final String page;
  @override
  Widget build(BuildContext context) {
    var product = Get.find<ElectronicsController>().electronicsList[pageId!];
    Get.find<ElectronicsController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularFoodImgSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(product.image!),
                ),
              ),
            ),
          ),
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      if (page == 'cartpage') {
                        Get.toNamed(RouteHelper.getcartPage());
                      } else {
                        Get.toNamed(RouteHelper.getInitialPage());
                      }
                    },
                    child: AppIcon(icon: Icons.arrow_back_ios)),
                GetBuilder<ElectronicsController>(
                    builder: (electronicsController) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getcartPage());
                    },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined),
                        Get.find<ElectronicsController>().totalItems >= 1
                            ? Positioned(
                                right: 0,
                                top: 0,
                                child: AppIcon(
                                  icon: Icons.circle,
                                  size: 20,
                                  iconColor: Colors.transparent,
                                  backgroundColor: AppColors.mainColor,
                                ),
                              )
                            : Container(),
                        Get.find<ElectronicsController>().totalItems >= 1
                            ? Positioned(
                                top: 3,
                                right: 3,
                                child: BigText(
                                  text: Get.find<ElectronicsController>()
                                      .totalItems
                                      .toString(),
                                  size: 12,
                                  color: Colors.white,
                                ),
                              )
                            : Container()
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodImgSize - 20,
            child: Container(
              padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                top: Dimensions.height20,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  ),
                  color: Colors.white),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(
                      text: product.title!,
                      ratingRate: product.rating!.rate,
                      ratingCount: product.rating!.count,
                    ),
                    SizedBox(height: Dimensions.height20),
                    BigText(text: 'Introduce'),
                    SizedBox(height: Dimensions.height20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExpandableTextWidget(text: product.description!),
                      ),
                    ),
                  ]),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GetBuilder<ElectronicsController>(builder: (electronicsController) {
              return Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  bottom: Dimensions.height20,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          electronicsController.setQuantity(false);
                        },
                        child: Icon(Icons.remove, color: AppColors.signColor)),
                    SizedBox(width: Dimensions.width10 / 2),
                    BigText(text: electronicsController.inCartItem.toString()),
                    SizedBox(width: Dimensions.width10 / 2),
                    GestureDetector(
                        onTap: (() {
                          electronicsController.setQuantity(true);
                        }),
                        child: Icon(Icons.add, color: AppColors.signColor)),
                  ],
                ),
              );
            }),
            GetBuilder<ElectronicsController>(builder: (electronicsController) {
              return Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  bottom: Dimensions.height20,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                ),
                child: GestureDetector(
                  onTap: () {
                    electronicsController.addItem(product);
                  },
                  child: BigText(
                      text: '\$ ${product.price} | Add to cart',
                      color: Colors.white),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: AppColors.mainColor,
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
