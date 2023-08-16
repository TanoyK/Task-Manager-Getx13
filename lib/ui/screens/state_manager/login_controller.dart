import 'package:get/get.dart';
import 'package:task_manager_getx/data/models/auth_utility.dart';
import 'package:task_manager_getx/data/models/login_model.dart';
import 'package:task_manager_getx/data/models/network_response.dart';
import 'package:task_manager_getx/data/services/network_caller.dart';
import 'package:task_manager_getx/data/utils/urls.dart';



class LoginController extends GetxController{
  bool _loginInProgress = false;
  bool get loginProgress => _loginInProgress;


  Future<bool> login(String email, String password) async {
    _loginInProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password
    };
    final NetworkResponse response = await NetworkCaller().postRequest(
        Urls.login, requestBody, isLogin: true);
    _loginInProgress = false;

    update();
    if(response.isSuccess){
      await AuthUtility.saveUserInfo(LoginModel.fromJson(response.body!));

      return true;
    }else{
     return false;
    }
  }
}