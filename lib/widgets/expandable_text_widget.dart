import 'package:e_commerce_app_getx/utils/colors.dart';
import 'package:e_commerce_app_getx/utils/dimension.dart';
import 'package:e_commerce_app_getx/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHaft;
  late String secondHaft;
  bool hiddenText = true;

  double textHeight = Dimensions.screenHeight / 5.36;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHaft = widget.text.substring(0, textHeight.toInt());
      secondHaft =
          widget.text.substring(textHeight.toInt(), widget.text.length);
    } else {
      firstHaft = widget.text;
      secondHaft = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHaft.isEmpty
          ? SmallText(text: firstHaft)
          : Column(
              children: [
                SmallText(
                  height: 1.8,
                  color: AppColors.paraColor,
                  size: Dimensions.font16,
                  text: hiddenText
                      ? (firstHaft + '...')
                      : (firstHaft + secondHaft),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      SmallText(text: 'Show more', color: AppColors.mainColor),
                      Icon(
                          hiddenText
                              ? Icons.arrow_drop_down
                              : Icons.arrow_drop_up,
                          color: AppColors.mainColor)
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
