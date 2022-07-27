import 'package:e_commerce_app_getx/ui/pages/cart/cart_page.dart';
import 'package:e_commerce_app_getx/ui/pages/food/electronics_page_detail.dart';
import 'package:e_commerce_app_getx/ui/pages/home/home_page.dart';
import 'package:e_commerce_app_getx/ui/pages/home/main_product_page.dart';
import 'package:get/get.dart';
import '../ui/pages/food/women_clothing_page_detail.dart';

class RouteHelper {
  static const String initial = '/';
  static const String electronics = '/electronics';
  static const String womenClothing = '/womenClothing';
  static const String cart = '/cart';

  static String getInitial() => '$initial';
  static String getElectronics(int pageId, String page) =>
      '$electronics?pageId=$pageId&page=$page';
  static String getWomenClothing(int pageId, String page) =>
      '$womenClothing?pageId=$pageId&page=$page';
  static String getcart() => '$cart';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => HomePage()),
    GetPage(
        name: electronics,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return ElectronicsPageDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: womenClothing,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return WomenClothingPageDetail(
              pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cart,
        page: () {
          return Cartpage();
        },
        transition: Transition.fadeIn),
  ];
}
