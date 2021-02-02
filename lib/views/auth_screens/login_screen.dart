import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/controllers/auth_controller.dart';

import 'package:pos_app/views/auth_screens/register_screen.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class LoginScreen extends GetWidget<AuthModel> {
  final _form = GlobalKey<FormState>();
   final AuthModel controllerss = Get.put(AuthModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 15, 0, 15),
            child: Container(
              width: 200,
              height: 35,
              child: Text(
                'Login to Your Account',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 30,
                ),
              ),
            ),
          ),
          Form(
            key: _form,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    autocorrect: true,
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (val) => controller.email = val,
                    validator: Validators.compose([
                      Validators.required('E-mail or Phone is Required'),
                      
                    ]),
                    decoration: InputDecoration(
                      hintText: 'E-mail or Phone',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    onSaved: (value) => controller.password = value,
                    obscureText: true,
                    validator: Validators.compose([
                      Validators.required('Password is required.'),
                      Validators.minLength(6, 'Please Enter 6 or more Characters')
                    ]),
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              Get.to(RegisterScreen());
            },
            child: Text('Don\'t have an account ? Register'),
          ),
          SizedBox(
            height: 25,
          ),
         Obx((){
           if(controller.loading.value){
             return Center(child: CircularProgressIndicator(),);
           }
           else
           return   Padding(
            padding: const EdgeInsets.all(12.0),
            child: RaisedButton(
              onPressed: () {
                if (_form.currentState.validate()) {
                  _form.currentState.save();
                  controller.signInAccount();
                }
              },
              child: Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.blue,
            ),
          );
         })
        ],
      ),
    );
  }
}
