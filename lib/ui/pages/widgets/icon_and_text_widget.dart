import 'package:e_commerce_app_getx/ui/pages/widgets/small_text.dart';
import 'package:flutter/material.dart';
import '../../utils/dimension.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  const IconAndTextWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: Dimensions.iconSize24),
        SizedBox(width: 5),
        SmallText(text: text),
      ],
    );
  }
}
