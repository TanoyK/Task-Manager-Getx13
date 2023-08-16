import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager_getx/app.dart';
import 'package:task_manager_getx/data/models/auth_utility.dart';
import 'package:task_manager_getx/data/models/network_response.dart';
import 'package:task_manager_getx/ui/screens/auth/login_screen.dart';


class NetworkCaller {
  Future<NetworkResponse> getRequest(String url) async {
    try {
      Response response = await get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'token': AuthUtility.userInfo.token.toString(),
      });
      if (response.statusCode == 200) {
        return NetworkResponse(
            true, response.statusCode, jsonDecode(response.body));
      } else {
        return NetworkResponse(false, response.statusCode, null);
      }
    } catch (e) {
      log(e.toString());
    }
    return NetworkResponse(false, -1, null);
  }

  Future<NetworkResponse> postRequest(String url,
      Map<String, dynamic> body, {bool isLogin = false} ) async {
    try {
      log(body.toString());
      Response response = await post(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'token': AuthUtility.userInfo.token.toString(),
      }, body: jsonEncode(body),
      );
      log(response.statusCode.toString());
      log(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
            true, response.statusCode, jsonDecode(response.body));
      }else if(response.statusCode == 401){
        if(isLogin == false){
          gotoLogin();
        }
      }
      else {
        return NetworkResponse(false, response.statusCode, null);
      }
    } catch (e) {
      log(e.toString());
    }
    return NetworkResponse(false, -1, null);
  }

  Future<void> gotoLogin() async {
    await AuthUtility.clearUserInfo();
    Navigator.pushAndRemoveUntil(
        TaskManagerApp.globalKey.currentState!.context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
         (route) => false);
  }
}