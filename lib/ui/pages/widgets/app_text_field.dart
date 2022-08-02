import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/dimension.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hinText;
  final IconData iconData;
  const AppTextField(
      {Key? key,
      required this.textEditingController,
      required this.hinText,
      required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius30),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 10),
            blurRadius: 10,
            spreadRadius: 7,
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hinText,
          prefixIcon: Icon(iconData, color: AppColors.yellowColor),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius30),
            borderSide: BorderSide(
              width: 1.0,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius30),
            borderSide: BorderSide(
              width: 1.0,
              color: Colors.white,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius30),
          ),
        ),
      ),
    );
  }
}
