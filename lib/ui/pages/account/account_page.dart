import 'package:e_commerce_app_getx/controllers/auth_controller.dart';
import 'package:e_commerce_app_getx/controllers/cart_controller.dart';
import 'package:e_commerce_app_getx/controllers/user_controller.dart';
import 'package:e_commerce_app_getx/routes/route_helper.dart';
import 'package:e_commerce_app_getx/ui/pages/widgets/account_widget.dart';
import 'package:e_commerce_app_getx/ui/pages/widgets/app_icon.dart';
import 'package:e_commerce_app_getx/ui/pages/widgets/big_text.dart';
import 'package:e_commerce_app_getx/ui/pages/widgets/custom_loader.dart';
import 'package:e_commerce_app_getx/ui/pages/widgets/show_custom_snackbar.dart';
import 'package:e_commerce_app_getx/ui/utils/colors.dart';
import 'package:e_commerce_app_getx/ui/utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (userLoggedIn) {
      Get.find<UserController>().getUser();
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: BigText(
            text: 'Profile',
            size: 24,
            color: Colors.white,
          ),
          centerTitle: true,
        ),
        body: GetBuilder<UserController>(
          builder: (userController) {
            return userLoggedIn
                ? (userController.isLoading
                    ? Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(top: Dimensions.height20),
                        child: Column(
                          children: [
                            // Profile
                            AppIcon(
                              icon: Icons.person,
                              backgroundColor: AppColors.mainColor,
                              iconColor: Colors.white,
                              iconSize: Dimensions.width45 + Dimensions.width30,
                              size: Dimensions.width30 * 5,
                            ),
                            SizedBox(height: Dimensions.height30),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    // Name
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.person,
                                        backgroundColor: AppColors.mainColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                        text: userController.user!.username!,
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.height20),
                                    // Phone
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.phone,
                                        backgroundColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                        text: userController.user!.phone!,
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.height20),
                                    // Email
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.email,
                                        backgroundColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                        text: userController.user!.email!,
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.height20),
                                    // Address
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.location_on,
                                        backgroundColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                          text: userController
                                              .user!.address!.city!),
                                    ),
                                    SizedBox(height: Dimensions.height20),
                                    // Message
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.message_outlined,
                                        backgroundColor: Colors.redAccent,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                        text: "Message",
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.height20),
                                    GestureDetector(
                                      onTap: () {
                                        if (Get.find<AuthController>()
                                            .userLoggedIn()) {
                                          Get.find<AuthController>()
                                              .clearSharedData();
                                          Get.find<CartController>().clear();
                                          Get.find<CartController>()
                                              .clearCarthistory();
                                          Get.toNamed(
                                              RouteHelper.getSignInPage());
                                        } else {
                                          showCustomSnackbar('You logged out',
                                              title: "Unable to perform");
                                        }
                                      },
                                      child: AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.logout,
                                          backgroundColor: Colors.redAccent,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(
                                          text: "Logout",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.height20),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : CustomLoader())
                : Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: double.maxFinite,
                            height: Dimensions.height20 * 8,
                            margin: EdgeInsets.only(
                                left: Dimensions.width20,
                                right: Dimensions.width20),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/image/signintocontinue.png"),
                              ),
                            ),
                          ),
                          SizedBox(height: Dimensions.height30),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.getSignInPage());
                            },
                            child: Container(
                              width: double.maxFinite,
                              height: Dimensions.height20 * 3,
                              margin: EdgeInsets.only(
                                  left: Dimensions.width20,
                                  right: Dimensions.width20),
                              decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                              ),
                              child: Center(
                                child: BigText(
                                  text: "Sign in",
                                  color: Colors.white,
                                  size: Dimensions.font16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ));
  }
}
