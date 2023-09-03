import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/data/models/task_list_model.dart';
import 'package:task_manager_getx/data/utils/urls.dart';
import '../../../data/models/network_response.dart';
import '../../../data/services/network_caller.dart';


class AllTaskController extends GetxController {
  TaskListModel _taskListModel = TaskListModel();
  TaskListModel get taskListModel => _taskListModel;


  bool _getProgress = false;
  bool get getProgress => _getProgress;


  Future<bool> deleteTask(String taskId) async {
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.deleteTask(taskId));
    if (response.isSuccess) {
      _taskListModel.data!.removeWhere((element) => element.sId == taskId);
      update();
      Get.snackbar(
          "Delete", "Task successfully deleted",);
      return true;
    } else {
      update();
      Get.snackbar("Delete", "Deletion of the task has been failed",
          );
      return false;
    }
  }


  Future<bool> getAllTask(String bottomTaskUrl) async {
    _getProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller().getRequest(bottomTaskUrl);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
      _getProgress = false;
      update();
      return true;
    } else {
      update();
      Get.snackbar(
          "Task Status", "Task failed", );
      return false;
    }
  }


}