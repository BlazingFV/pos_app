import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pos_app/views/auth_screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  startTimeout() {
    return  Timer(Duration(seconds: 2), changeScreen);
  }

  changeScreen() async{
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context){
          return LoginScreen();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTimeout();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(left: 40.0, right: 40.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.cake,
                size: 150.0,
                color: Colors.black,
              ),

              SizedBox(width: 40.0),

              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  top: 15.0,
                ),
                child: Text(
                  "Nozom E-Commerce",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}