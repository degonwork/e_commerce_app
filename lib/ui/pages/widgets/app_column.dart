import 'package:e_commerce_app_getx/ui/pages/widgets/big_text.dart';
import 'package:e_commerce_app_getx/ui/pages/widgets/icon_and_text_widget.dart';
import 'package:e_commerce_app_getx/ui/pages/widgets/small_text.dart';

import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/dimension.dart';

class AppColumn extends StatelessWidget {
  final String text;
  final num ratingRate;
  final int ratingCount;

  const AppColumn(
      {Key? key,
      required this.text,
      required this.ratingRate,
      required this.ratingCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimensions.font26,
        ),
        SizedBox(height: Dimensions.height10),
        Row(
          children: [
            Wrap(
              children: List.generate(
                5,
                (index) =>
                    Icon(Icons.star, color: AppColors.mainColor, size: 15),
              ),
            ),
            SizedBox(width: 10),
            SmallText(text: '$ratingRate'),
            SizedBox(width: 10),
            SmallText(text: '$ratingCount'),
            SizedBox(width: 10),
            SmallText(text: 'reviews'),
          ],
        ),
        SizedBox(height: Dimensions.height20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
              icon: Icons.circle_sharp,
              text: 'Normal',
              iconColor: AppColors.iconColor1,
            ),
            IconAndTextWidget(
              icon: Icons.location_on,
              text: '1.7km',
              iconColor: AppColors.mainColor,
            ),
            IconAndTextWidget(
              icon: Icons.access_time_rounded,
              text: '32min',
              iconColor: AppColors.iconColor2,
            )
          ],
        ),
      ],
    );
  }
}
