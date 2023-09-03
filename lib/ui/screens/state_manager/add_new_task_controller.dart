
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/data/models/network_response.dart';
import 'package:task_manager_getx/data/services/network_caller.dart';
import 'package:task_manager_getx/data/utils/urls.dart';


class AddNewTaskController extends GetxController{
  bool _addNewTaskInProgress = false;
  bool get addNewTaskInProgress => _addNewTaskInProgress;

  final TextEditingController _titleTEController = TextEditingController();
  get titleTEController => _titleTEController;
  final TextEditingController _descriptionTEController = TextEditingController();
  get descriptionTEController => _descriptionTEController;


  Future<bool> addNewTask() async{
    _addNewTaskInProgress = true;

    update();

    Map<String, dynamic> requestBody = {
      "title": _titleTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
      "status":"New"
    };
    final NetworkResponse response = await
    NetworkCaller().postRequest(Urls.createTask, requestBody );
    _addNewTaskInProgress = false;

    update();

    if(response.isSuccess){
      _titleTEController.clear();
      _descriptionTEController.clear();

      update();
      Get.snackbar('Add', 'Task add successfully');
      // if(mounted){
      //   ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(content: Text('Task added successfully')));
      // }
      return true;

    }else{

      update();
      Get.snackbar('Add', 'Task add successfully');

      return false;
      // if(mounted){
      //   ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(content: Text('Task add failed')));
      // }
    }
  }
}