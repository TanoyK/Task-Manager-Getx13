import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager_getx/data/models/task_list_model.dart';
import 'package:task_manager_getx/ui/screens/state_manager/update_task_status_bottom_sheet_controller.dart';


class UpdateTaskStatusSheet extends StatefulWidget {
  final TaskData task;
  final VoidCallback onUpdate;

  const UpdateTaskStatusSheet({super.key, required this.task, required this.onUpdate});

  @override
  State<UpdateTaskStatusSheet> createState() => _UpdateTaskStatusSheetState();
}

class _UpdateTaskStatusSheetState extends State<UpdateTaskStatusSheet> {
  List<String> taskStatusList = ['New', 'Progress', 'Canceled', 'Completed'];
  late String _selectedTask;

  final UpdateTaskStatusBottomSheetController updateTaskStatusBottomSheetController = Get.put(UpdateTaskStatusBottomSheetController());

  @override
  void initState() {
    _selectedTask = widget.task.status!.toLowerCase();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Column(
        children: [
          const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Update Status')),
          Expanded(
            child: ListView.builder(
                itemCount: taskStatusList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: (){
                      _selectedTask = taskStatusList[index];
                      setState(() {});
                    },
                    title: Text(taskStatusList[index].toUpperCase()),
                    trailing: _selectedTask == taskStatusList[index] ? const Icon(Icons.check) : null,
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Visibility(
              visible: updateTaskStatusBottomSheetController.isUpdateStatusInProgress == false,
              replacement:  const Center(
                child: CircularProgressIndicator(),
              ),
              child: ElevatedButton(onPressed: (){
                updateTaskStatusBottomSheetController.updateTask(widget.task.sId!, _selectedTask);
              },
                  child: const Text('Update')),
            ),
          )
        ],
      ),
    );
  }
}
