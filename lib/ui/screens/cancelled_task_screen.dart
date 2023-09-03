import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/data/utils/urls.dart';
import 'package:task_manager_getx/ui/screens/state_manager/all_task_controller.dart';
import 'package:task_manager_getx/ui/screens/utils/getx_bottom_sheet.dart';
import 'package:task_manager_getx/ui/screens/widgets/task_list_tile.dart';
import 'package:task_manager_getx/ui/screens/widgets/user_profile_banner.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {

  final AllTaskController allTaskController = Get.put<AllTaskController>(AllTaskController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      allTaskController.getAllTask(Urls.inCancelledTask);
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
            GetBuilder<AllTaskController>(
              builder: (allTaskController) {
                return Expanded(
                  child: allTaskController.getProgress ? const Center(
                      child: CircularProgressIndicator()
                  )
                      :ListView.separated(
                    itemCount: allTaskController.taskListModel.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TaskListTile(
                        data: allTaskController.taskListModel.data![index],
                        onDeleteTap: () {
                          allTaskController.deleteTask(allTaskController.taskListModel.data![index].sId!);
                        },
                        onEditTap: () {
                          showBottomSheetTaskStatusGetx(
                              allTaskController.taskListModel.data![index],
                          Urls.inCancelledTask);
                        },
                      );
                      // return const TaskListTile();
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(height: 4.0,);
                    },
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
