import 'package:e_commerce_app_getx/utils/colors.dart';
import 'package:e_commerce_app_getx/utils/dimension.dart';
import 'package:e_commerce_app_getx/widgets/app_icon.dart';
import 'package:e_commerce_app_getx/widgets/big_text.dart';
import 'package:e_commerce_app_getx/widgets/expandable_text_widget.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_column.dart';

class PopularFoodPageDetail extends StatelessWidget {
  const PopularFoodPageDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularFoodImgSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/image/food0.png'),
                ),
              ),
            ),
          ),
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.arrow_back_ios),
                AppIcon(icon: Icons.shopping_cart_outlined),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodImgSize - 20,
            child: Container(
              padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                top: Dimensions.height20,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  ),
                  color: Colors.white),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(
                      text: 'Chinese Side',
                      ratingRate: 4.5,
                      ratingCount: 1287,
                    ),
                    SizedBox(height: Dimensions.height20),
                    BigText(text: 'Introduce'),
                    SizedBox(height: Dimensions.height20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExpandableTextWidget(
                            text:
                                'Chúng ta cần hiểu rằng, giúp người là tự giúp chính mình còn hại người cũng như hại mình, mình gieo nhân nào thì có ngày cũng sẽ gặp lại quả ấy thôi. Khi xưa, ông cha ta đã kiên cường chiến thắng được sách đô hộ, xâm lược của kẻ thù nhờ có tinh thần đoàn kết của toàn dân tộc. không chỉ thế, trong cuộc sống, con người ta sẽ có lúc hoạn nạn, khó khăn mà không thể lường trước được, và không thể một mình tự vượt qua. Khi ấy, cần có những bàn tay nâng đỡ ta dậy, giúp ta vượt qua những gian nan, thử thách ấy. Ta được người khác giúp đỡ thì đến lúc họ gặp khó khăn thì chúng ta sẽ là người đưa tay ra giúp đỡ họ. Khi biết sống yêu thương, sẻ chia, ta cũng sẽ giúp cho cuộc sống này ngày càng trở nên tốt đẹp hơn, con người ta biết sống vì cộng đồng, vì tập thể, từ bỏ những ích kỷ cá nhân để sống vị tha, để đống góp một phần nhỏ của mình đến cuộc sống xung quanh. Xã hội sẽ luôn tràn ngập tình yêu thương, gắn bó chính nhờ sự cảm thông, sẻ chia là chiếc cầu nối giữa con người với con người, mà khi một xã hội đã đoàn kết để cùng hướng về một mục tiêu chung thì xã hội ấy sẽ ngày càng một phát triển đạt được những thành quả nhất định. Một lối sống tốt đẹp là biết sống vị tha, tuy nhiên không phải ai cũng dễ dàng có được đức tính ấy, mà còn phụ thuộc vào sự rèn luyện, đó là một cả quá trình dài. Khi một người gặp khó khăn thì mọi người xung quanh không được phép thờ ơ, hững hờ, mà hãy sẵn sàng quan tâm, sẻ chia và ra tay giúp đỡ. Con người ta cần biết học cách sẻ chia nhiều hơn, đồng cảm nhiều hơn hi sinh nhiều hơn, luôn hướng về cái thiện, khát khao xây dựng một cuộc sống tốt đẹp. Tất nhiên, trong xã hội phức tạp như hiện nay, lòng tốt đôi khi bị lợi dụng, khiến người ta trở nên ích kỉ hơn không dám đưa tay giúp đỡ người khác vì sợ bản thân sẽ gặp nguy hiểm và đã có rất nhiều trường hợp xấu đã xảy ra khi giúp người lạ. Vì thế mà ta cần phải biết cho đi tình thương đúng người, đúng lúc, đúng chỗ, đúng hoàn cảnh, không nên phân phát nó một cách bừa bãi, kể cả những hoàn cảnh không hề khó khăn hay những con người xấu xa. Bên cạnh đó, cũng cần lên án và bài trừ một số người có lối sống ích kỷ, hẹp hòi, vô cảm trước những hoàn cảnh khó khăn, không có tinh thần tập thể, thờ ơ với những xung quanh, thậm chí là chính người thân của họ.'),
                      ),
                    ),
                  ]),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: Dimensions.bottomHeightBar,
        padding: EdgeInsets.only(
          top: Dimensions.height20,
          bottom: Dimensions.height20,
          left: Dimensions.width20,
          right: Dimensions.width20,
        ),
        decoration: BoxDecoration(
          color: AppColors.buttonBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius20 * 2),
            topRight: Radius.circular(Dimensions.radius20 * 2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(
                top: Dimensions.height20,
                bottom: Dimensions.height20,
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Icon(Icons.remove, color: AppColors.signColor),
                  SizedBox(width: Dimensions.width10 / 2),
                  BigText(text: '0'),
                  SizedBox(width: Dimensions.width10 / 2),
                  Icon(Icons.add, color: AppColors.signColor),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: Dimensions.height20,
                bottom: Dimensions.height20,
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              child: BigText(text: '\$10 | Add to cart', color: Colors.white),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: AppColors.mainColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
