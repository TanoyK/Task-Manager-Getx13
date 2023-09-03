





import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../data/models/network_response.dart';
import '../../../data/services/network_caller.dart';
import '../../../data/utils/urls.dart';

class UpdateProfileController extends GetxController {



  final _emailController = TextEditingController();
  get emailController => _emailController;
  final _firstNameController = TextEditingController();
  get firstNameController => _firstNameController;
  final _lastNameController = TextEditingController();
  get lastNameController => _lastNameController;
  final _mobileController = TextEditingController();
  get mobileController => _mobileController;
  final _passwordController = TextEditingController();
  get passwordController => _passwordController;

  bool _profileUpdateInProgress = false;
  bool get profileUpdateInProgress => _profileUpdateInProgress;

  Future<bool> updateProfile() async {
    _profileUpdateInProgress = true;
    update();
    final Map<String, dynamic> responseBody = {
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobile": _mobileController.text.trim(),
      //"photo": ""
    };

    if (_passwordController.text.isNotEmpty) {
      responseBody["password"] = _passwordController.text;
    }

    final NetworkResponse response =
    await NetworkCaller().postRequest(Urls.updateProfile, responseBody);

    _profileUpdateInProgress = false;
    update();
    if (response.isSuccess) {
      _passwordController.clear();
      update();
      return true;
    } else {
      return false;
    }
  }


}