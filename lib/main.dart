import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pos_app/helpers/bindings.dart';
import 'package:pos_app/views/auth_screens/login_screen.dart';
import 'package:pos_app/views/cart_screen/check_outscreen/cart_screen.dart';
import 'package:pos_app/views/splash_screen.dart';
import 'package:pos_app/views/user_screens/addresses_screen.dart';
import 'package:pos_app/views/user_screens/profile_screen.dart';

import 'views/auth_screens/register_screen.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: Binding(),
      title: 'El-Nozom',
      theme: ThemeData(),
      home: SplashScreen(),
    );
  }
}
