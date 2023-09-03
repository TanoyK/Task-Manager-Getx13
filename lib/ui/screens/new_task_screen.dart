import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/data/models/task_list_model.dart';
import 'package:task_manager_getx/ui/screens/add_new_task_screen.dart';
import 'package:task_manager_getx/ui/screens/state_manager/all_task_controller.dart';
import 'package:task_manager_getx/ui/screens/state_manager/new_task_controller.dart';
import 'package:task_manager_getx/ui/screens/state_manager/summary_count_controller.dart';
import 'package:task_manager_getx/ui/screens/update_task_bottom_sheet.dart';
import 'package:task_manager_getx/ui/screens/update_task_status_sheet.dart';
import 'package:task_manager_getx/ui/screens/widgets/screen_background.dart';
import 'package:task_manager_getx/ui/screens/widgets/summary_card.dart';
import 'package:task_manager_getx/ui/screens/widgets/task_list_tile.dart';
import 'package:task_manager_getx/ui/screens/widgets/user_profile_banner.dart';

import '../../data/utils/urls.dart';


class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final TaskListModel _taskListModel = TaskListModel();

  final AllTaskController allTaskController = Get.put<AllTaskController>(AllTaskController());

 // final NewTaskController _newTaskController = Get.put<NewTaskController>(NewTaskController());
  final SummaryCountController _summaryCountController = Get.put<SummaryCountController>(SummaryCountController());


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _summaryCountController.getCountSummary();
      allTaskController.getAllTask(Urls.newTask);

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Column(
          children: [
            const UserProfileAppBar(),

            GetBuilder<SummaryCountController>(builder: (_) {
                if(_summaryCountController.getCountSummaryInProgress){
                  return const Center(
                    child: LinearProgressIndicator(),
                  );
                }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 80,
                      width: double.infinity,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _summaryCountController.summaryCountModel.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return SummaryCard(
                            title: _summaryCountController.summaryCountModel.data![index].sId ?? 'New',
                            number: _summaryCountController.summaryCountModel.data![index].sum ?? 0,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(height: 4.0,);
                        },
                      ),
                    ),
                  );
                }
              ),

            Expanded(
              child: GetBuilder<AllTaskController>(
                builder: (allTaskController) {
                  return RefreshIndicator(
                    onRefresh: () async {
                     allTaskController.getAllTask(Urls.newTask);
                      _summaryCountController.getCountSummary();
                    },

                   child : allTaskController.getProgress ? const Center(
                     child: CircularProgressIndicator(),
                   ):ListView.separated(
                      itemCount: allTaskController.taskListModel.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return TaskListTile(
                          data: allTaskController.taskListModel.data![index],
                          onDeleteTap: () {
                            allTaskController.deleteTask(allTaskController.taskListModel.data![index].sId!);
                          },
                          onEditTap: () {
                           // showEditBottomSheet(_taskListModel.data![index]);
                            showStatusUpdateBottomSheet(allTaskController.taskListModel.data![index]);
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(height: 4.0,);
                      },
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {

            Get.to(const AddNewTaskScreen());
            // Navigator.push(context,
            //     MaterialPageRoute(
            //         builder: (context) => const AddNewTaskScreen()));
          }
      ),
    );
  }

  void showEditBottomSheet(TaskData task) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return UpdateTaskSheet(task: task, onUpdate: () {
            allTaskController.getAllTask(Urls.newTask);
          },);
        });
  }

  void showStatusUpdateBottomSheet(TaskData task) {
    List<String> taskStatusList = ['new', 'progress', 'cancel', 'completed'];
    String _selectedTask = task.status!.toLowerCase();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return UpdateTaskStatusSheet(task: task, onUpdate: (){
          allTaskController.getAllTask(Urls.updateTask('id', 'status'));
        });
      },
    );
  }
}



