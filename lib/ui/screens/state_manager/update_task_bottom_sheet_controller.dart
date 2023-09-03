

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../data/models/network_response.dart';
import '../../../data/services/network_caller.dart';
import '../../../data/utils/urls.dart';

class UpdateTaskBottomSheetController extends GetxController {

  final  _titleController = TextEditingController();
  get titleController => _titleController;
  final  _descriptionController = TextEditingController();
  get descriptionController => _descriptionController;

  bool _updateTaskInProgress =false;
  bool get updateTaskInProgress => _updateTaskInProgress;


  Future<bool> updateTask() async {
    _updateTaskInProgress = true;
    update();

    Map<String, dynamic> responseBody = {
      "title": _titleController.text.trim(),
      "description": _descriptionController.text.trim(),
    };

    // need to change
    final NetworkResponse response = await NetworkCaller().postRequest(Urls.createTask, responseBody);

    _updateTaskInProgress = false;
    update();
    if (response.isSuccess) {
      _titleController.clear();
      _descriptionController.clear();
      update();
      return true;
    }
    else {
      return false;
    }
  }

}