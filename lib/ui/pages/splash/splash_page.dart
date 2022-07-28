import 'dart:async';

import 'package:e_commerce_app_getx/routes/route_helper.dart';
import 'package:e_commerce_app_getx/ui/utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/electronics_controller.dart';
import '../../../controllers/women_clothing_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResource() async {
    await Get.find<ElectronicsController>().getElectronicsList();
    await Get.find<WomenClothingController>().getWomenClothingList();
  }

  @override
  void initState() {
    super.initState();
    _loadResource();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(Duration(seconds: 3), () => Get.offNamed(RouteHelper.initial));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                'assets/image/logo part 1.png',
                width: Dimensions.splashImg,
              ),
            ),
          ),
          Center(
            child: Image.asset(
              'assets/image/logo part 2.png',
              width: Dimensions.splashImg,
            ),
          ),
        ],
      ),
    );
  }
}
