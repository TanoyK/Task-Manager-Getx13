


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager_getx/data/models/task_list_model.dart';
import 'package:task_manager_getx/ui/screens/update_task_status_sheet.dart';

import '../state_manager/all_task_controller.dart';

showBottomSheetTaskStatusGetx(TaskData taskData, bottomSheet){

  final AllTaskController allTaskController = Get.put<AllTaskController>(AllTaskController());

  Get.bottomSheet(
    Card(
      elevation: 5,
      child: Container(
        height: 350,
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: UpdateTaskStatusSheet(
              task: taskData,
              onUpdate: () {
                allTaskController.getAllTask(bottomSheet);
              },
            )),
      ),
    ),
    enableDrag: false,
    isDismissible: false,
    // barrierColor: Colors.indigo[200],
  );
}