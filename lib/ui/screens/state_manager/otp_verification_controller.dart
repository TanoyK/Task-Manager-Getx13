import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/data/models/network_response.dart';
import 'package:task_manager_getx/data/services/network_caller.dart';
import 'package:task_manager_getx/data/utils/urls.dart';
import 'package:task_manager_getx/ui/screens/auth/reset_password_screen.dart';



class OtpVerificationController extends GetxController {
  bool _otpVerificationInProgress = false;
  bool get otpVerificationInProgress => _otpVerificationInProgress;

  final TextEditingController _otpTEController = TextEditingController();
  get otpTEController => _otpTEController;


  Future<bool> verifyOtp(String email)async{
    _otpVerificationInProgress = true;
   update();
    final NetworkResponse response = await
    NetworkCaller().getRequest(Urls.otpVerify(email, _otpTEController.text));
    _otpVerificationInProgress = false;

    update();

    if(response.body!['status'] == 'success'){

      // Navigator.push(context, MaterialPageRoute(
        //     builder: (context) => ResetPasswordScreen(
        //         email: widget.email, otp: _otpTEController.text)));
      return true;
    } else{

      return false;

      }
  }
}