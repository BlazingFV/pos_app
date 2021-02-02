import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pos_app/controllers/user_controller.dart';
import 'package:pos_app/views/auth_screens/login_screen.dart';
import 'package:pos_app/views/home_screen/home_screen.dart';
import 'package:pos_app/views/user_screens/addresses_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthModel extends GetxController {
  String email, password, phone, name;
  var loading = false.obs;
  var token;
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    autoAuthenticate();
    super.onInit();
  }

  UserController controller = Get.put(UserController());

  createAccount() async {
    String responsebodyy = '';
    loading(true);
    String url = 'http://nozomecom.esolve-eg.com/api/register';

    final body = json.encode(
      {
        'email': email,
        'name': name,
        'password': password,
        'phone': phone,
      },
    );
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8',
          'Accept': 'application/json'
        },
        body: body,
      );
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        responsebodyy = response.body;
        Get.snackbar(
          'registered',
          'You Registered Successfully',
        );

        loading(false);
        Future.delayed(Duration(milliseconds: 450), () {
          loading(false);
          Get.offAll(LoginScreen());
        });
      }
    } catch (message) {
      loading(false);
      Get.snackbar(
        'error logging in your account',
        responsebodyy.toString(),
      );
    }
  }

  signInAccount() async {
    String responseBodyy = '';
    loading(true);
    String url = 'http://nozomecom.esolve-eg.com/api/login';
    final body = json.encode({
      'emailOrPhone': email,
      'password': password,
    });
    try {
      final response = await http.post(
        url,
        body: body,
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8',
          'Accept': 'application/json',
        },
      );
      // print(response.body);
      responseBodyy = response.body;
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData.containsKey('access_token')) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String token = responseData['access_token'];
        prefs.setString('token', '');
        prefs.setString('token', token);
        

        // prefs.setString('token', '');
        // print('$token');
        print(response.body);
       

        Future.delayed(Duration(milliseconds: 550), () {
          loading(false);
          controller.getUser(token);
        });
         Get.snackbar(
          'Logged In',
          'You Logged In Successfully',
        );
      }
    } catch (message) {
      loading(false);
      Get.snackbar(
        'error logging in your account',
        responseBodyy.toString(),
      );
    }
  }

  autoAuthenticate() async {
    loading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (token != null) {
      controller.autoAuthenticate();
      Timer.periodic(Duration(milliseconds: 3000), (timer) { 
      loading(false);
      });
    } else if (token == null) {
      
      loading(false);
    }
  }
}
