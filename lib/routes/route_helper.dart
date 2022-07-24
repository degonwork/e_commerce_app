import 'package:e_commerce_app_getx/ui/pages/food/electronics_page_detail.dart';
import 'package:e_commerce_app_getx/ui/pages/home/main_product_page.dart';
import 'package:get/get.dart';
import '../ui/pages/food/women_clothing_page_detail.dart';

class RouteHelper {
  static const String initial = '/';
  static const String electronics = '/electronics';
  static const String womenClothing = '/womenClothing';

  static String getInitial() => '$initial';
  static String getElectronics(int pageId) => '$electronics?pageId=$pageId';
  static String getWomenClothing(int pageId) => '$womenClothing?pageId=$pageId';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => MainProductPage()),
    GetPage(
        name: electronics,
        page: () {
          var pageId = Get.parameters['pageId'];
          return ElectronicsPageDetail(pageId: int.parse(pageId!));
        },
        transition: Transition.fadeIn),
    GetPage(
        name: womenClothing,
        page: () {
          var pageId = Get.parameters['pageId'];
          return WomenClothingPageDetail(pageId: int.parse(pageId!));
        },
        transition: Transition.fadeIn),
  ];
}
