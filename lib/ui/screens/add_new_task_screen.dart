import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/data/models/network_response.dart';
import 'package:task_manager_getx/data/services/network_caller.dart';
import 'package:task_manager_getx/data/utils/urls.dart';
import 'package:task_manager_getx/ui/screens/state_manager/add_new_task_controller.dart';
import 'package:task_manager_getx/ui/screens/widgets/user_profile_banner.dart';


class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {

  final AddNewTaskController addNewTaskController = Get.put<AddNewTaskController>(AddNewTaskController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UserProfileAppBar(
              isUpdateScreen: true,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16,),
                  Text('Add new task',
                    // style: TextStyle(
                    // fontSize: 30,
                    // fontWeight: FontWeight.w400,
                    // color: Colors.black,

                    // ),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16,),
                   TextFormField(
                     controller: addNewTaskController.titleTEController,
                    decoration: const InputDecoration(
                      hintText: 'Title'
                    ),
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: addNewTaskController.descriptionTEController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                        hintText: 'Description'
                    ),
                  ),
                  const SizedBox(height: 16,),
                  SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: addNewTaskController.addNewTaskInProgress == false,
                            replacement: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: ElevatedButton(
                            onPressed: (){
                              addNewTaskController.addNewTask();
                        } ,
                            child: const Icon(Icons.arrow_forward_ios)),
                      )
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
