import 'package:e_commerce_app_getx/ui/pages/home/product_page_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/electronics_controller.dart';
import '../../../controllers/women_clothing_controller.dart';
import '../../utils/colors.dart';
import '../../utils/dimension.dart';
import '../widgets/big_text.dart';
import '../widgets/small_text.dart';

class MainProductPage extends StatefulWidget {
  const MainProductPage({Key? key}) : super(key: key);

  @override
  State<MainProductPage> createState() => _MainProductPageState();
}

class _MainProductPageState extends State<MainProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Show header
          Container(
            child: Container(
              margin: EdgeInsets.only(
                  top: Dimensions.height45, bottom: Dimensions.height15),
              padding: EdgeInsets.only(
                  left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(
                        text: 'Bangladesh',
                        color: AppColors.mainColor,
                      ),
                      Row(
                        children: [
                          SmallText(text: 'Narsingdi', color: Colors.black54),
                          Icon(Icons.arrow_drop_down_rounded),
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      width: Dimensions.width45,
                      height: Dimensions.height45,
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: Dimensions.iconSize24,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                        color: AppColors.mainColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // Show the body
          Expanded(
            child: SingleChildScrollView(
              child: ProductPageBody(),
            ),
          ),
        ],
      ),
    );
  }
}
