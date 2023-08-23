import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/ui/screens/auth/signup_screen.dart';
import 'package:task_manager_getx/ui/screens/bottom_nav_base_screen.dart';
import 'package:task_manager_getx/ui/screens/email_verification_screen.dart';
import 'package:task_manager_getx/ui/screens/state_manager/login_controller.dart';
import 'package:task_manager_getx/ui/screens/widgets/screen_background.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  //final LoginController loginController = Get.put<LoginController>(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      const SizedBox(height: 64),
                     Text('Get Started',
                      // style: TextStyle(
                      // fontSize: 30,
                      // fontWeight: FontWeight.w400,
                      // color: Colors.black,

                    // ),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        )
                    ),
                    const SizedBox(height: 12,),
                    TextField(
                      controller: _passwordTEController,
                      obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        )
                    ),
                    const SizedBox(height: 12,),
                    GetBuilder<LoginController>(
                      builder: (loginController) {
                        return SizedBox(
                          width: double.infinity,
                            child: Visibility(
                              visible: loginController.loginProgress == false,
                              replacement: const Center(
                                child: CircularProgressIndicator(),
                              ),
                              child: ElevatedButton(
                                  onPressed: (){
                                       loginController.login(
                                       _emailTEController.text.trim(),
                                           _passwordTEController.text
                                       ).then((result) {
                                         if(result == true){
                                           Get.off(() =>const BottomNavBaseScreen());
                                         } else {
                                           Get.snackbar('Failed', 'Login failed try again.');
                                         }
                                       });
                              } ,
                                  child: const Icon(Icons.arrow_forward_ios)),
                            ),
                          );
                      }
                    ),
                    const SizedBox(height: 16,),
                    Center(
                        child: InkWell(onTap: (){

                          Get.to(const EmailVerificationScreen());

                          // Navigator.push(context, MaterialPageRoute(
                          //     builder: (context) => const EmailVerificationScreen()));
                        },
                            child: const Text('Forget Password',
                              style: TextStyle(
                          color: Colors.grey,
                        ),))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?", style: TextStyle(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5
                        ),),
                        TextButton(onPressed: (){

                          Get.off(() => const SignUpScreen());

                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) =>
                          //     const SignUpScreen()));
                        }, child: const Text('Sign up')),
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



