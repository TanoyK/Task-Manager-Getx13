


import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../data/models/network_response.dart';
import '../../../data/services/network_caller.dart';
import '../../../data/utils/urls.dart';

class UpdateTaskStatusBottomSheetController extends GetxController {

  bool _isUpdateStatusInProgress = false;
  bool get isUpdateStatusInProgress => _isUpdateStatusInProgress;


  Future<bool> updateTask(String taskId, String newStatus) async {
    _isUpdateStatusInProgress = true;
    update();

    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.updateTask(taskId, newStatus));
    if (response.isSuccess) {
      _isUpdateStatusInProgress = false;
      update();
      return true;
    } else {
      return false;
    }
  }

}