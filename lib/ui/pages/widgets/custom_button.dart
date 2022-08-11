import 'package:e_commerce_app_getx/ui/utils/dimension.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final double radius;
  final IconData? icon;
  const CustomButton(
      {Key? key,
      this.onPressed,
      required this.buttonText,
      this.transparent = false,
      this.margin,
      this.height,
      this.width,
      this.fontSize,
      this.radius = 5,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextButton.styleFrom(
      backgroundColor: onPressed == null
          ? Theme.of(context).disabledColor
          : transparent
              ? Colors.transparent
              : Theme.of(context).primaryColor,
      minimumSize: Size(
        width == null ? width! : Dimensions.screenWidth,
        height == null ? height! : Dimensions.height10 * 5,
      ),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );
    return Container();
  }
}
