import 'package:flutter/material.dart';
import 'package:task_manager_getx/data/models/network_response.dart';
import 'package:task_manager_getx/data/models/summary_count_model.dart';
import 'package:task_manager_getx/data/models/task_list_model.dart';
import 'package:task_manager_getx/data/services/network_caller.dart';
import 'package:task_manager_getx/data/utils/urls.dart';
import 'package:task_manager_getx/ui/screens/add_new_task_screen.dart';
import 'package:task_manager_getx/ui/screens/update_task_bottom_sheet.dart';
import 'package:task_manager_getx/ui/screens/update_task_status_sheet.dart';
import 'package:task_manager_getx/ui/screens/widgets/screen_background.dart';
import 'package:task_manager_getx/ui/screens/widgets/summary_card.dart';
import 'package:task_manager_getx/ui/screens/widgets/task_list_tile.dart';
import 'package:task_manager_getx/ui/screens/widgets/user_profile_banner.dart';


class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getCountSummaryInProgress = false,
      _getNewTaskInProgress = false;
  SummaryCountModel _summaryCountModel = SummaryCountModel();
  TaskListModel _taskListModel = TaskListModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCountSummary();
      getNewTask();
    });
  }

  Future<void> getCountSummary() async {
    _getCountSummaryInProgress = true;
    if (mounted) {
      setState(() {

      });
    }
    final NetworkResponse response = await NetworkCaller().getRequest(
        Urls.taskStatusCount);
    if (response.isSuccess) {
      _summaryCountModel = SummaryCountModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Get new task data failed")));
      }
    }
    _getCountSummaryInProgress = false;
    if (mounted) {
      setState(() {

      });
    }
  }

  Future<void> getNewTask() async {
    _getNewTaskInProgress = true;
    if (mounted) {
      setState(() {

      });
    }
    final NetworkResponse response = await NetworkCaller().getRequest(
        Urls.newTask);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Summary data get failed")));
      }
    }
    _getNewTaskInProgress = false;
    if (mounted) {
      setState(() {

      });
    }
  }

  Future<void> deleteTask(String taskId) async {
    final NetworkResponse response = await NetworkCaller().getRequest(
        Urls.deleteTask(taskId));
    if (response.isSuccess) {
      _taskListModel.data!.removeWhere((element) => element.sId == taskId);
      if (mounted) {
        setState(() {

        });
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Deletion of task has been failed')));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Column(
          children: [
            const UserProfileAppBar(
              isUpdateScreen: false,
            ),
            _getCountSummaryInProgress ?
            const LinearProgressIndicator()
                : Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 80,
                width: double.infinity,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _summaryCountModel.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return SummaryCard(
                      title: _summaryCountModel.data![index].sId ?? 'New',
                      number: _summaryCountModel.data![index].sum ?? 0,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(height: 4.0,);
                  },
                ),
              ),
            ),

            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  getNewTask();
                  getCountSummary();
                },
                child: _getNewTaskInProgress ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : ListView.separated(
                  itemCount: _taskListModel.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return TaskListTile(
                      data: _taskListModel.data![index],
                      onDeleteTap: () {
                        deleteTask(_taskListModel.data![index].sId!);
                      },
                      onEditTap: () {
                       // showEditBottomSheet(_taskListModel.data![index]);
                        showStatusUpdateBottomSheet(_taskListModel.data![index]);
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(height: 4.0,);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => const AddNewTaskScreen()));
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
            getNewTask();
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
          getNewTask();
        });
      },
    );
  }
}



