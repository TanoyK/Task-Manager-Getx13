import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/data/models/auth_utility.dart';
import 'package:task_manager_getx/ui/screens/auth/login_screen.dart';
import 'package:task_manager_getx/ui/screens/update_profile_screen.dart';


class UserProfileAppBar extends StatefulWidget {
  final bool? isUpdateScreen;
  const UserProfileAppBar({
    super.key,
    this.isUpdateScreen,
  });

  @override
  State<UserProfileAppBar> createState() => _UserProfileAppBarState();
}

class _UserProfileAppBarState extends State<UserProfileAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: (){
          if((widget.isUpdateScreen ?? false) == false) {

            // Get.off(() => const UpdateProfileScreen());

            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UpdateProfileScreen()
                ));

          }
        },
        child: Row(
          children: [
             Visibility(
               visible: (widget.isUpdateScreen ?? false) == false,
               child: Row(
                 children: [
                   CachedNetworkImage(
                     placeholder:(_,__) => const Icon(Icons.account_circle_outlined),
                    imageUrl: AuthUtility.userInfo.data?.photo ?? '',
                     errorWidget:(_,__,___) => const Icon(Icons.account_circle_outlined),

                ),
                const SizedBox(
                   width: 16,
                   ),
                 ],
               ),
             ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${AuthUtility.userInfo.data?.firstName ?? ''} ${AuthUtility.userInfo.data?.firstName ?? ''}",
                  style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
                ),
              Text(
                AuthUtility.userInfo.data?.email ?? 'Unknown',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
              ],
            ),
          ],
        ),
      ),

      actions: [
          IconButton(
            onPressed: () async {
             await AuthUtility.clearUserInfo();

             if(mounted) {

              // Get.offAll(const LoginScreen());
               Navigator.pushAndRemoveUntil(context,
                   MaterialPageRoute(builder: (context) => const LoginScreen()),
                       (route) => false);
             }
             },
            icon: const Icon(Icons.logout),
          ),
        ],
    );
  }
}
