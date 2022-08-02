import 'package:e_commerce_app_getx/ui/pages/widgets/app_icon.dart';
import 'package:e_commerce_app_getx/ui/pages/widgets/big_text.dart';
import 'package:e_commerce_app_getx/ui/utils/dimension.dart';
import 'package:flutter/material.dart';

class AccountWidget extends StatelessWidget {
  const AccountWidget({Key? key, required this.appIcon, required this.bigText})
      : super(key: key);
  final AppIcon appIcon;
  final BigText bigText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: Dimensions.width20,
        top: Dimensions.width10,
        bottom: Dimensions.width10,
      ),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          offset: Offset(0, 2),
          blurRadius: 1,
          color: Colors.grey.withOpacity(0.2),
        )
      ]),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.width20),
          bigText,
        ],
      ),
    );
  }
}
