import 'dart:convert';

import 'package:e_commerce_app_getx/controllers/auth_controller.dart';
import 'package:e_commerce_app_getx/data/models/signup_body_model.dart';
import 'package:e_commerce_app_getx/data/responsitory/auth_repo.dart';
import 'package:e_commerce_app_getx/routes/route_helper.dart';
import 'package:e_commerce_app_getx/ui/pages/widgets/app_text_field.dart';
import 'package:e_commerce_app_getx/ui/pages/widgets/big_text.dart';
import 'package:e_commerce_app_getx/ui/pages/widgets/show_custom_snackbar.dart';
import 'package:e_commerce_app_getx/ui/utils/colors.dart';
import 'package:e_commerce_app_getx/ui/utils/dimension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController userNameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    List<String> signUpIcon = [
      'assets/image/t.png',
      'assets/image/f.png',
      'assets/image/g.png',
    ];
    void _registration() {
      var authController = Get.find<AuthController>();
      String username = userNameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      Map<String, dynamic> nameMap = {"firstname": 'John', "lastname": 'Doe'};
      Map<String, dynamic> geolocationMap = {
        "lat": '-37.3159',
        "long": '81.1496'
      };
      Map<String, dynamic> addressMap = {
        "city": 'kilcoole',
        "street": '7835 new road',
        "number": 3,
        "zipcode": '12926-3874',
        "geolocation": geolocationMap,
      };

      if (username.isEmpty) {
        showCustomSnackbar('Type in your user name', title: "User name");
      } else if (phone.isEmpty) {
        showCustomSnackbar('Type in your phone number', title: "Phone number");
      } else if (email.isEmpty) {
        showCustomSnackbar('Type in your email address', title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackbar('Type in a valid email address',
            title: "Valid email address");
      } else if (password.isEmpty) {
        showCustomSnackbar('Type in your password', title: "Password");
      } else if (password.length < 6) {
        showCustomSnackbar("Password can't be less than six characters",
            title: "Password");
      } else {
        Map<String, dynamic> signUpBodyMap = {
          "email": email,
          "username": username,
          "password": password,
          "phone": phone,
          'name': nameMap,
          "address": addressMap,
        };
        SignUpBody signUpBody = SignUpBody.fromJson(signUpBodyMap);
        showCustomSnackbar("All went well", title: "Perfect");
        authController.registration(signUpBody).then(
          (status) {
            if (status.isSuccess) {
              print("Success registration");
              print(status.message);
            } else {
              showCustomSnackbar(status.message);
            }
          },
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                  backgroundImage: AssetImage('assets/image/logo part 1.png'),
                ),
              ),
            ),
            AppTextField(
              textEditingController: emailController,
              hinText: "Email",
              iconData: Icons.email,
            ),
            SizedBox(height: Dimensions.height20),
            AppTextField(
              textEditingController: passwordController,
              hinText: "Password",
              iconData: Icons.password_sharp,
            ),
            SizedBox(height: Dimensions.height20),
            AppTextField(
              textEditingController: userNameController,
              hinText: "User Name",
              iconData: Icons.person,
            ),
            SizedBox(height: Dimensions.height20),
            AppTextField(
              textEditingController: phoneController,
              hinText: "Phone",
              iconData: Icons.phone,
            ),
            SizedBox(height: Dimensions.height20),
            GestureDetector(
              onTap: _registration,
              child: Container(
                width: Dimensions.screenWidth / 2,
                height: Dimensions.screenHeight / 13,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                ),
                child: Center(
                  child: BigText(
                    text: "Sign up",
                    size: Dimensions.font20 + Dimensions.font20 / 2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: Dimensions.height10),
            RichText(
              text: TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Get.toNamed(RouteHelper.signIn),
                text: 'Have an account already?',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimensions.font20,
                ),
              ),
            ),
            SizedBox(height: Dimensions.screenHeight * 0.05),
            RichText(
              text: TextSpan(
                text: 'Sign up using one of the following methods',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimensions.font16,
                ),
              ),
            ),
            SizedBox(height: Dimensions.height10 / 2),
            Wrap(
              children: List.generate(
                  3,
                  (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: Dimensions.radius30,
                          backgroundImage: AssetImage(
                            signUpIcon[index],
                          ),
                        ),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
