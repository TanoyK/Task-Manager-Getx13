import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_getx/data/models/login_model.dart';


class AuthUtility {
  AuthUtility._();
  static LoginModel userInfo = LoginModel();

  static Future<void> saveUserInfo(LoginModel model) async {
    SharedPreferences _sharedPre = await SharedPreferences.getInstance();
    await _sharedPre.setString('user-data', jsonEncode(model.toJson()));
    userInfo = model;
  }

  static Future<void> updateUserInfo(UserData data) async {
    SharedPreferences _sharedPre = await SharedPreferences.getInstance();
    userInfo.data = data;
    await _sharedPre.setString('user-data', jsonEncode(userInfo.toJson()));

  }

  static Future<LoginModel> getUserInfo() async {
    SharedPreferences _sharedPre = await SharedPreferences.getInstance();
    String value = _sharedPre.getString('user-data')!;
    return LoginModel.fromJson(jsonDecode(value));
  }

  static Future<void> clearUserInfo() async {
    SharedPreferences _sharedPre = await SharedPreferences.getInstance();
    await  _sharedPre.clear();
  }

  static Future<bool> checkIfUserLoggedIn() async {
    SharedPreferences _sharedPre = await SharedPreferences.getInstance();
    bool isLogin = _sharedPre.containsKey('user-data');
    if(isLogin){
      userInfo = await getUserInfo();
    }
    return isLogin;
  }

}