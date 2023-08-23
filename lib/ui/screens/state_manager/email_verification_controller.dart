import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/data/models/network_response.dart';
import 'package:task_manager_getx/data/services/network_caller.dart';
import 'package:task_manager_getx/data/utils/urls.dart';
import 'package:task_manager_getx/ui/screens/auth/otp_verification_screen.dart';



class EmailVerificationController extends GetxController {
  bool _emailVerificationInProgress = false;

  bool get emailVerificationInProgress => _emailVerificationInProgress;
  final TextEditingController _emailTEController = TextEditingController();

  get emailTEController => _emailTEController;


  Future<bool> sendOTPToEmail() async {
    _emailVerificationInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller()
        .getRequest(Urls.sendOtpToEmail(_emailTEController.text.trim()));
    _emailVerificationInProgress = false;

    update();

    if (response.isSuccess) {
      Get.to(OtpVerificationScreen(email: _emailTEController.text.trim()));

      // Navigator.push(
      //     context, MaterialPageRoute(
      //     builder: (context) =>
      //         OtpVerificationScreen(
      //           email: _emailTEController.text.trim(),)));
      return true;
    } else {
      Get.snackbar('Fail','Email verification has been failed.');
      return false;
    }
  }
}