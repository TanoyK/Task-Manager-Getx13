import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/ui/screens/auth/login_screen.dart';
import 'package:task_manager_getx/ui/screens/state_manager/reset_password_controller.dart';
import 'package:task_manager_getx/ui/screens/widgets/screen_background.dart';


class ResetPasswordScreen extends StatefulWidget {
  final String email, otp;
  const ResetPasswordScreen({super.key, required this.email, required this.otp});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  final ResetPasswordController resetPasswordController =
  Get.put<ResetPasswordController>(ResetPasswordController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 64),
                    Text('Set Password',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    Text('Minimum password should be a letters with number and symbols',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: resetPasswordController.passwordTEController,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        ),
                      validator: (String? value){
                        if(value?.isEmpty ?? true){
                          return 'Enter your password';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16,),

                     TextFormField(
                       controller: resetPasswordController.confirmTEController,
                      obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Confirm Password',
                        ),
                       validator: (String? value){
                         if(value?.isEmpty ?? true){
                           return 'Enter your confirm password';
                         }else if(value! != resetPasswordController.passwordTEController){
                            return "Confirm password does n\'t match";
                         }
                         return null;
                       },
                    ),

                    const SizedBox(height: 16,),
                    SizedBox(
                        width: double.infinity,
                        child: Visibility(
                          visible: resetPasswordController.setPasswordInProgress == false,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ElevatedButton(
                            onPressed: (){

                            if(_formKey.currentState!.validate()){
                              resetPasswordController.resetPassword(
                                widget.email, widget.otp).then((value){
                                if(value == true){
                                  Get.snackbar('Success','Password reset successful');
                                  Get.offAll(() => const LoginScreen());
                                }
                                else{
                                  Get.snackbar('Fail', 'Reset password failed');
                                }
                              });
                            }
                          } ,
                              child: const Text('Confirm'),
                          ),
                        ),
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
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) =>
                              const LoginScreen()), (route)=> false);
                        },
                            child: const Text('Sign in')),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
