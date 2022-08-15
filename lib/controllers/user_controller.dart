import 'dart:convert';
import 'package:e_commerce_app_getx/data/responsitory/user_repo.dart';
import 'package:get/get.dart';
import '../data/models/user_model.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({required this.userRepo});
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<User> _listUser = [];
  List<User> get listUser => _listUser;

  User? _user;
  User? get user => _user;

  Future<void> getListUserInfo() async {
    Response response = await userRepo.getUserInfo();
    if (response.statusCode == 200) {
      print("got user info");
      List<dynamic> result = jsonDecode(jsonEncode(response.body));
      _listUser = [];
      for (var element in result) {
        _listUser.add(User.fromJson(element));
      }
    } else {
      print('error');
    }
    update();
  }

  void getUser() {
    _isLoading = true;
    String username = userRepo.getUsername();
    String password = userRepo.getPassword();
    for (var element in listUser) {
      if (element.username == username) {
        if (element.password == password) {
          _user = element;
        }
      }
    }
  }
}
