import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/ui/screens/auth/login_screen.dart';
import 'package:task_manager_getx/ui/screens/state_manager/signup_controller.dart';
import 'package:task_manager_getx/ui/screens/widgets/screen_background.dart';



class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final SignupController signupController = Get.put<SignupController>(SignupController());
  // home task form validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      const SizedBox(height: 64),
                     Text('Join with us',
                      // style: TextStyle(
                      // fontSize: 30,
                      // fontWeight: FontWeight.w400,
                      // color: Colors.black,

                    // ),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                        controller: signupController.emailTEController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                      validator: (String? value ){
                        if(value?.isEmpty ?? true){
                          return 'Enter your email';

                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: signupController.firstNameTEController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: 'First name',
                        ),
                        // three word name check validation by use (&& operation)
                        validator: (String? value ){
                            if(value?.isEmpty ?? true){
                              return 'Enter your first name';
                         }
                           return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                        controller: signupController.lastNameTEController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: 'Last name',
                        ),
                        validator: (String? value ){
                              if(value?.isEmpty ?? true){
                                 return 'Enter your last name';

                             }
                               return null;
                        },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: signupController.mobileTEController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Mobile',
                        ),
                      validator: (String? value ){
                        if((value?.isEmpty ?? true) && value!.length < 11){
                          return 'Enter your valid mobile number';

                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12,),
                    TextFormField(
                      controller: signupController.passwordTEController,
                      obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        ),
                      validator: (String? value ){
                        if((value?.isEmpty ?? true) || value!.length <= 5){
                          return 'Enter a password more than 6 letter';

                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12,),
                    GetBuilder<SignupController>(
                      builder: (sigUpController) {
                        return SizedBox(
                          width: double.infinity,
                          child: Visibility(
                            visible: sigUpController.signupProgress == false,
                            replacement: const Center(
                                child: CircularProgressIndicator()),
                            child: ElevatedButton(
                                onPressed: (){
                                  if(! _formKey.currentState!.validate()){
                                    return;
                                  }
                                  sigUpController.userSignUp(

                                  )
                                   .then((result) {
                                      if(result == true){
                                        Get.snackbar('Success', 'Signup success');
                                        Get.off(() => const LoginScreen());
                                      }else{
                                        Get.snackbar('Failed', 'Signup failed');
                                      }
                                  });

                            } , child: const Icon(Icons.arrow_forward_ios)),
                          ));
                      }
                    ),

                    const SizedBox(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Have an account?", style: TextStyle(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5
                        ),),
                        TextButton(onPressed: (){

                          Get.to(const LoginScreen());

                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) => const LoginScreen()));
                        }, child: const Text('Sign In')),
                      ],
                    )
                  ]
                ),
              ),
            ),
        ),
        ),

    );
  }
}



