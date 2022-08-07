import 'package:e_commerce_app_getx/ui/pages/address/add_address_page.dart';
import 'package:e_commerce_app_getx/ui/pages/cart/cart_page.dart';
import 'package:e_commerce_app_getx/ui/pages/food/electronics_page_detail.dart';
import 'package:e_commerce_app_getx/ui/pages/home/home_page.dart';
import 'package:e_commerce_app_getx/ui/pages/splash/splash_page.dart';
import '../ui/pages/auth/sign_in_page.dart';
import '../ui/pages/auth/sign_up_page.dart';
import '../ui/pages/food/women_clothing_page_detail.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = '/';
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String splash = '/splash';
  static const String electronics = '/electronics';
  static const String womenClothing = '/womenClothing';
  static const String cart = '/cart';
  static const String addAddress = '/add-address';

  static String getInitialPage() => '$initial';
  static String getSplashPage() => '$splash';
  static String getSignInPage() => '$signIn';
  static String getSignUpPage() => '$signUp';
  static String getElectronicsPage(int pageId, String page) =>
      '$electronics?pageId=$pageId&page=$page';
  static String getWomenClothingPage(int pageId, String page) =>
      '$womenClothing?pageId=$pageId&page=$page';
  static String getcartPage() => '$cart';
  static String getAddAddressPage() => '$addAddress';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => HomePage()),
    GetPage(name: splash, page: () => SplashPage()),
    GetPage(
        name: signIn, page: () => SignInPage(), transition: Transition.fade),
    GetPage(
        name: signUp, page: () => SignUpPage(), transition: Transition.fade),
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
    GetPage(
        name: addAddress,
        page: () {
          return AddAddressPage();
        },
        transition: Transition.fadeIn),
  ];
}
