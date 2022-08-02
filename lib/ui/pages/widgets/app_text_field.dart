import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/dimension.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hinText;
  final IconData iconData;
  bool isObscure;
  AppTextField({
    Key? key,
    required this.textEditingController,
    required this.hinText,
    required this.iconData,
    this.isObscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 3,
            spreadRadius: 1,
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
      child: TextField(
        obscureText: isObscure,
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hinText,
          prefixIcon: Icon(iconData, color: AppColors.yellowColor),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            borderSide: BorderSide(
              width: 1.0,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            borderSide: BorderSide(
              width: 1.0,
              color: Colors.white,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
          ),
        ),
      ),
    );
  }
}
