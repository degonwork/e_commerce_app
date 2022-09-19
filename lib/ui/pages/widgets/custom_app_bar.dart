import 'package:e_commerce_app_getx/ui/pages/widgets/big_text.dart';
import 'package:e_commerce_app_getx/ui/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Size get preferredSize => const Size(500, 50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.mainColor,
      elevation: 0,
      title: BigText(
        text: title,
        color: Colors.white,
      ),
      centerTitle: true,
      leading: SizedBox(),
    );
  }
}
