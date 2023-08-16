import 'package:flutter/material.dart';
import 'package:task_manager_getx/data/models/network_response.dart';
import 'package:task_manager_getx/data/models/task_list_model.dart';
import 'package:task_manager_getx/data/services/network_caller.dart';
import 'package:task_manager_getx/data/utils/urls.dart';
import 'package:task_manager_getx/ui/screens/widgets/task_list_tile.dart';
import 'package:task_manager_getx/ui/screens/widgets/user_profile_banner.dart';


class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  bool _getProgressTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();




  Future<void> getInProgressTask() async {
    _getProgressTaskInProgress= true;
    if(mounted){
      setState(() {

      });
    }
    final NetworkResponse response = await NetworkCaller().getRequest(Urls.inProgressTask);
    if(response.isSuccess){
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else{
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("In progress tasks get failed")));
      }
    }
    _getProgressTaskInProgress = false;
    if(mounted){
      setState(() { });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getInProgressTask();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const UserProfileAppBar(
              isUpdateScreen: false,
            ),
            Expanded(
              child: _getProgressTaskInProgress ? const Center(
                  child: CircularProgressIndicator()
              )
                  :ListView.separated(
                itemCount: _taskListModel.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return TaskListTile(
                      data: _taskListModel.data![index],
                    onDeleteTap: () {  },
                    onEditTap: () {  },
                  );
                 // return const TaskListTile();
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(height: 4.0,);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}