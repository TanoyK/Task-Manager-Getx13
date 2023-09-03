import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/data/models/network_response.dart';
import 'package:task_manager_getx/data/services/network_caller.dart';
import 'package:task_manager_getx/data/utils/urls.dart';
import 'package:task_manager_getx/ui/screens/auth/otp_verification_screen.dart';



class ResetPasswordController extends GetxController {
  bool _setPasswordInProgress = false;
  bool get setPasswordInProgress => _setPasswordInProgress;

  final TextEditingController _passwordTEController = TextEditingController();
  get passwordTEController => _passwordTEController;
  final TextEditingController _confirmTEController = TextEditingController();
  get confirmTEController => _confirmTEController;


  Future<bool> resetPassword(String email, String otp)async{
    _setPasswordInProgress = true;

    update();

    final Map<String,dynamic> requestBody = {
      "email": email,
      "OTP": otp,
      "password": _passwordTEController.text
    };

    final NetworkResponse response = await
    NetworkCaller().postRequest(Urls.resetPassword, requestBody);
    _setPasswordInProgress = false;

    update();

    if(response.isSuccess){

     // Get.snackbar('Success', 'Password reset successful!');

        // Navigator.pushAndRemoveUntil(context,
        //     MaterialPageRoute(builder: (context) => const LoginScreen()),
        //         (route) => false);
      return false;
      }
        else{

          //Get.snackbar('Failed', 'Reset Password has been failed');
          return false;
        }
  }
}