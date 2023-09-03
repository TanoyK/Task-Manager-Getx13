import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_getx/data/models/auth_utility.dart';
import 'package:task_manager_getx/data/models/login_model.dart';
import 'package:task_manager_getx/data/models/network_response.dart';
import 'package:task_manager_getx/data/services/network_caller.dart';
import 'package:task_manager_getx/data/utils/urls.dart';
import 'package:task_manager_getx/ui/screens/state_manager/update_profile_controller.dart';
import 'package:task_manager_getx/ui/screens/widgets/screen_background.dart';
import 'package:task_manager_getx/ui/screens/widgets/user_profile_banner.dart';


class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  UserData userData = AuthUtility.userInfo.data!;
  final TextEditingController _emailTEController = TextEditingController(text: AuthUtility.userInfo.data!.email ?? '');
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final UpdateProfileController updateProfileController =
  Get.put<UpdateProfileController>(UpdateProfileController());

  // home task form validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile? imageFile;
  ImagePicker picker = ImagePicker();
  bool _profileInProgress = false;

  @override
  void initState() {
    super.initState();
    _emailTEController.text = userData?.email ?? "";
    _firstNameTEController.text = userData?.firstName ?? "";
    _lastNameTEController.text = userData?.lastName ?? "";
    _mobileTEController.text = userData?.mobile ?? "";
  }

  Future<void> updateProfile() async{
    _profileInProgress = true;
    if(mounted){
      setState(() { });
    }
    final Map<String, dynamic> requestBody = {
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
      "password": _passwordTEController.text,
      "photo":""
    };
    if(_passwordTEController.text.isNotEmpty){
      requestBody['password'] = _passwordTEController.text;
    }
    final NetworkResponse response = await NetworkCaller().postRequest(Urls.updateProfile, requestBody );
    _profileInProgress = false;
    if(mounted){
      setState(() { });
    }
    if(response.isSuccess){
      userData.firstName = _firstNameTEController.text.trim();
      userData.lastName = _lastNameTEController.text.trim();
      userData.mobile = _mobileTEController.text.trim();
      AuthUtility.updateUserInfo(userData);
      _passwordTEController.clear();
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile update')));
      }
    }else{
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile update failed try again')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const UserProfileAppBar(
                        isUpdateScreen: true,
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('Update profile',
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleLarge,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                           selectImage();
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: Colors.white
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(14),
                                color: Colors.grey,
                                child: const Text('Photos', style: TextStyle(
                                  color: Colors.white,
                                ),),
                              ),
                              const SizedBox(width: 16,),
                              Visibility(
                                  visible: imageFile != null,
                                  child: Text(imageFile?.name ?? '')),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _emailTEController,
                        keyboardType: TextInputType.emailAddress,
                        readOnly: true,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _firstNameTEController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: 'First name',
                        ),
                        // three word name check validation by use (&& operation)
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Enter your first name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _lastNameTEController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: 'Last name',
                        ),
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Enter your last name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _mobileTEController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Mobile',
                        ),
                        validator: (String? value) {
                          if ((value?.isEmpty ?? true) && value!.length < 11) {
                            return 'Enter your valid mobile number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12,),
                      TextFormField(
                        controller: _passwordTEController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        ),
                        validator: (String? value) {
                          if ((value?.isEmpty ?? true) || value!.length <= 5) {
                            return 'Enter a password more than 6 letter';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12,),
                      SizedBox(
                        width: double.infinity,
                        child: _profileInProgress ? const Center(
                          child: CircularProgressIndicator(),)
                            :ElevatedButton(
                               onPressed: () {
                                 updateProfile();
                               },
                               child: const Text('Update'),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

    void selectImage(){
      picker.pickImage(source: ImageSource.gallery).then((xFile) {
          if(xFile != null){
              imageFile = xFile;
              if(mounted){
                setState(() {
                  
                });
              }
          }
      });
    }
  }

