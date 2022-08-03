import 'package:e_commerce_app_getx/routes/route_helper.dart';
import 'package:e_commerce_app_getx/ui/pages/widgets/app_text_field.dart';
import 'package:e_commerce_app_getx/ui/pages/widgets/big_text.dart';
import 'package:e_commerce_app_getx/ui/pages/widgets/custom_loader.dart';
import 'package:e_commerce_app_getx/ui/utils/colors.dart';
import 'package:e_commerce_app_getx/ui/utils/dimension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../widgets/show_custom_snackbar.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    void _login(AuthController authController) {
      String username = usernameController.text.trim();
      String password = passwordController.text.trim();

      if (username.isEmpty) {
        showCustomSnackbar('Type in your user name', title: "User Name");
      } else if (password.isEmpty) {
        showCustomSnackbar('Type in your password', title: "Password");
      } else if (password.length < 6) {
        showCustomSnackbar("Password can't be less than six characters",
            title: "Password");
      } else {
        showCustomSnackbar("All went well", title: "Perfect");
        authController.login(username, password).then(
          (status) {
            if (status.isSuccess) {
              print("Success login");
              Get.toNamed(RouteHelper.getInitialPage());
            } else {
              showCustomSnackbar(status.message);
            }
          },
        );
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (authController) {
            return !authController.isLoading
                ? SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(height: Dimensions.screenHeight * 0.05),
                        Container(
                          height: Dimensions.screenHeight * 0.25,
                          child: Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: Dimensions.width20 * 4,
                              backgroundImage:
                                  AssetImage('assets/image/logo part 1.png'),
                            ),
                          ),
                        ),
                        // Welcome
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(left: Dimensions.width20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello',
                                style: TextStyle(
                                  fontSize: Dimensions.font20 * 3 +
                                      Dimensions.font20 / 2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Sign into your account',
                                style: TextStyle(
                                  fontSize: Dimensions.font20,
                                  color: Colors.grey[500],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: Dimensions.height20),
                        AppTextField(
                          textEditingController: usernameController,
                          hinText: "User Name",
                          iconData: Icons.person,
                        ),
                        SizedBox(height: Dimensions.height20),
                        AppTextField(
                          isObscure: true,
                          textEditingController: passwordController,
                          hinText: "Password",
                          iconData: Icons.password_sharp,
                        ),
                        SizedBox(height: Dimensions.height20),
                        Row(
                          children: [
                            Expanded(child: Container()),
                            RichText(
                              text: TextSpan(
                                text: 'Sing into your account',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font20,
                                ),
                              ),
                            ),
                            SizedBox(width: Dimensions.width20),
                          ],
                        ),
                        SizedBox(height: Dimensions.screenHeight * 0.05),
                        GestureDetector(
                          onTap: () {
                            _login(authController);
                          },
                          child: Container(
                            width: Dimensions.screenWidth / 2,
                            height: Dimensions.screenHeight / 13,
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius30),
                            ),
                            child: Center(
                              child: BigText(
                                text: "Sign in",
                                size: Dimensions.font20 + Dimensions.font20 / 2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: Dimensions.screenHeight * 0.05),
                        RichText(
                          text: TextSpan(
                              text: "Don't an account",
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimensions.font20,
                              ),
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap =
                                        () => Get.toNamed(RouteHelper.signUp),
                                  text: " Create",
                                  style: TextStyle(
                                      color: AppColors.mainBlackColor,
                                      fontSize: Dimensions.font20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  )
                : CustomLoader();
          },
        ));
  }
}
