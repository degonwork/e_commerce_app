import 'package:e_commerce_app_getx/controllers/cart_controller.dart';
import 'package:e_commerce_app_getx/controllers/electronics_controller.dart';
import 'package:e_commerce_app_getx/controllers/women_clothing_controller.dart';
import 'package:e_commerce_app_getx/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce_app_getx/bindings/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<ElectronicsController>(
      builder: ((_) {
        return GetBuilder<WomenClothingController>(
          builder: (_) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              initialRoute: RouteHelper.getSignInPage(),
              getPages: RouteHelper.routes,
            );
          },
        );
      }),
    );
  }
}
