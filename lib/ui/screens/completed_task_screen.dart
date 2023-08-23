import 'package:flutter/material.dart';
import 'package:task_manager_getx/data/models/network_response.dart';
import 'package:task_manager_getx/data/models/task_list_model.dart';
import 'package:task_manager_getx/data/services/network_caller.dart';
import 'package:task_manager_getx/data/utils/urls.dart';
import 'package:task_manager_getx/ui/screens/widgets/task_list_tile.dart';
import 'package:task_manager_getx/ui/screens/widgets/user_profile_banner.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _getCompletedTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();


  Future<void> getInCompletedTask() async {
    _getCompletedTaskInProgress= true;
    if(mounted){
      setState(() {

      });
    }
    final NetworkResponse response = await NetworkCaller().getRequest(Urls.inCompletedTask);
    if(response.isSuccess){
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else{
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("In completed tasks get failed")));
      }
    }
    _getCompletedTaskInProgress = false;
    if(mounted){
      setState(() { });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

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
              child: _getCompletedTaskInProgress ? const Center(
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
