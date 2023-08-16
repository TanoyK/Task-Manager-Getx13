import 'package:flutter/material.dart';
import 'package:task_manager_getx/data/models/network_response.dart';
import 'package:task_manager_getx/data/services/network_caller.dart';
import 'package:task_manager_getx/data/utils/urls.dart';
import 'package:task_manager_getx/ui/screens/auth/login_screen.dart';
import 'package:task_manager_getx/ui/screens/widgets/screen_background.dart';



class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  // home task form validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _signUpInProgress = false;

  void userSignUp() async {
    _signUpInProgress = true;
    if(mounted){
      setState(() {

      });
    }
    // Note: Tow way to create a map body

    // Map<String, dynamic>  requestBody = {
    //   "email": _emailTEController.text.trim(),
    //   "firstName": _firstNameTEController.text.trim(),
    //   "lastName": _lastNameTEController.text.trim(),
    //   "mobile": _mobileTEController.text.trim(),
    //   "password": _passwordTEController.text,
    //   "photo":""
    // };


    final NetworkResponse response = await
    //NetworkCaller().postRequest(Urls.registration, requestBody);
    NetworkCaller().postRequest(Urls.registration, <String, dynamic> {
    "email": _emailTEController.text.trim(),
    "firstName": _firstNameTEController.text.trim(),
    "lastName": _lastNameTEController.text.trim(),
    "mobile": _mobileTEController.text.trim(),
    "password": _passwordTEController.text,
    "photo":""
    });

    _signUpInProgress = false;
    if(mounted){
      setState(() {

      });
    }

    if(response.isSuccess){
      _emailTEController.clear();
      _passwordTEController.clear();
      _firstNameTEController.clear();
      _lastNameTEController.clear();
      _mobileTEController.clear();
    if(mounted) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
    const SnackBar(content: Text('Registration success')));
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
    }
    }else{
    if(mounted) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Registration failed')));
    }
    }

  }

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
                        controller: _emailTEController,
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
                      controller: _firstNameTEController,
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
                        controller: _lastNameTEController,
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
                      controller: _mobileTEController,
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
                      controller: _passwordTEController,
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
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _signUpInProgress == false,
                        replacement: const Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(onPressed: (){
                          if(! _formKey.currentState!.validate()){
                              return;
                          }
                          userSignUp();

                        } , child: const Icon(Icons.arrow_forward_ios)),
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
                          Navigator.pop(context);
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



