import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/data/models/auth_utility.dart';
import 'package:task_manager_getx/ui/screens/auth/login_screen.dart';
import 'package:task_manager_getx/ui/screens/bottom_nav_base_screen.dart';
import 'package:task_manager_getx/ui/screens/utils/assets_utils.dart';
import 'package:task_manager_getx/ui/screens/widgets/screen_background.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigateToLogin();
  }

  Future<void> navigateToLogin() async {

    Future.delayed(const Duration(seconds: 3)).then((_) async {
      final bool isLoggedIn = await AuthUtility.checkIfUserLoggedIn();
      if(mounted) {

        Get.offAll(
            () => isLoggedIn
            ? const BottomNavBaseScreen()
            : const LoginScreen());

        // Navigator.pushAndRemoveUntil(context,
        //   MaterialPageRoute(
        //       builder: (context) =>
        //       isLoggedIn ? const BottomNavBaseScreen() : const LoginScreen()),
        //       (route) => false,
        // );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: SvgPicture.asset(
              AssetsUtils.logoSvg,
              width: 90,
              fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
