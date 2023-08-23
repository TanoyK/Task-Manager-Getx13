import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/data/models/network_response.dart';
import 'package:task_manager_getx/data/services/network_caller.dart';
import 'package:task_manager_getx/data/utils/urls.dart';



class SignupController extends GetxController{
  bool _signUpProgress = false;
  bool get signupProgress => _signUpProgress;

  final TextEditingController _emailTEController = TextEditingController();
  get emailTEController => _emailTEController;
  final TextEditingController _firstNameTEController = TextEditingController();
  get firstNameTEController => _firstNameTEController;
  final TextEditingController _lastNameTEController = TextEditingController();
  get lastNameTEController => _lastNameTEController;
  final TextEditingController _mobileTEController = TextEditingController();
  get mobileTEController => _mobileTEController;
  final TextEditingController _passwordTEController = TextEditingController();
  get passwordTEController => _passwordTEController;

  bool _signUpInProgress = false;

  Future<bool> userSignUp() async {
    _signUpInProgress = true;

    update();

    final NetworkResponse response = await
    //NetworkCaller().postRequest(Urls.registration, requestBody);
    NetworkCaller().postRequest(Urls.registration, <String, dynamic> {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
      "password": _passwordTEController.text,
      "photo":""
    });

    _signUpInProgress = false;

    update();

    if(response.isSuccess){
      _emailTEController.clear();
      _passwordTEController.clear();
      _firstNameTEController.clear();
      _lastNameTEController.clear();
      _mobileTEController.clear();

      return true;

      // if(mounted) {
      //   ScaffoldMessenger.of(context)
      //       .showSnackBar(
      //       const SnackBar(content: Text('Registration success')));
      //   Navigator.pushAndRemoveUntil(context,
      //       MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
      // }
    }else{
      return false;
    }
      // if(mounted) {
      //   ScaffoldMessenger.of(context)
      //       .showSnackBar(const SnackBar(content: Text('Registration failed')));
      // }
    }

  }