import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/ui/screens/auth/login_screen.dart';
import 'package:task_manager_getx/ui/screens/auth/otp_verification_screen.dart';
import 'package:task_manager_getx/ui/screens/state_manager/email_verification_controller.dart';
import 'package:task_manager_getx/ui/screens/widgets/screen_background.dart';



class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {

  final EmailVerificationController emailVerificationController = Get.put<EmailVerificationController>(EmailVerificationController());
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
                    Text('Your email address',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    Text('A 6 digit verification pin will send to your email address',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: emailVerificationController.emailTEController,
                      keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Enter your email address';
                        }
                        if(!GetUtils.isEmail(value)){
                          return 'Enter your valid email';
                        }
                        print('Email: ${GetUtils.isEmail(value)}');
                        return null;
                      },),

                    const SizedBox(height: 16,),
                    SizedBox(
                        width: double.infinity,
                        child: Visibility(
                          visible: emailVerificationController.emailVerificationInProgress == false,
                          replacement: const Center(
                            child: CircularProgressIndicator(),),
                          child: ElevatedButton(
                              onPressed: (){
                                if(_formKey.currentState!.validate()){
                                  emailVerificationController.sendOTPToEmail().then((value){

                                    if(value == true){
                                      Get.to(() => OtpVerificationScreen(email: emailVerificationController.emailTEController.text.trim()));
                                    }
                                    else{
                                      Get.snackbar('Fail', 'Email verification fail');
                                    }
                                  });

                                }
                                 } ,
                              child: const Icon(Icons.arrow_circle_right_outlined)),
                        )),

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
                          // Navigator.pop(context);
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
