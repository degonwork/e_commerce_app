class AppConstants {
  // App
  static const String APP_NAME = 'DBFood';
  static const int APP_VERSION = 1;

  // Base url
  static const String BASE_URL = 'https://fakestoreapi.com';
  static const String BASE_GOOGLE_MAPS_URL =
      'https://maps.googleapis.com/maps/api';

  // Product
  static const String ELECTRONICS_URL = "/products/category/electronics";
  static const String WOMEN_CLOTHING_URL =
      "/products/category/women's clothing";

  // Authenticate
  static const String USER_URL = "/users";
  static const String LOGIN_URL = "/auth/login";

  // Token and share preference
  static const String TOKEN = "DBtoken";
  static const String IDUSER = "Id-user";
  static const String USERNAME = "Username";
  static const String PASSWORD = "Password";

  static const String CART_LIST = "Cart-list";
  static const String CART_HISTORY_LIST = "Cart-history-list";

  static String GEOCODE_URL = "";
  static String USER_ADDRESS = "User-address";

  // Google maps
  static const String GOOGLE_MAPS_URL = "/geocode/json?";
  static const String SEARCH_LOCATION_URL = "/place/autocomplete/json?";
  static const String PLACE_DETAILS_URL = "/place/details/json?";
  static const String PLACE_ORDER_URL = "";

  // Api key google maps
  static const String GOOGLE_API_KEY =
      "AIzaSyCMESvjp3G5FtPnukZ28_GVOuFSvEhSS9c";
}
