import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/controllers/auth_controller.dart';
import 'package:pos_app/views/auth_screens/login_screen.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class RegisterScreen extends GetWidget<AuthModel> {
  // int radioValue = -1;
  // void _handleRadioValueChanged(int value) {
  //   setState(() {
  //     radioValue = value;
  //     print(radioValue);
  //   });
  // }
  final AuthModel controllerss = Get.put(AuthModel());
  final _form = GlobalKey<FormState>();

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
                'Create New Account',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 30,
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text('Title'),
          // ),
          // Container(
          //   width: 300,
          //   height: 45,
          //   child: buildRadioButtons(),
          // ),
          Form(
            key: _form,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    autocorrect: true,
                    onSaved: (value) => controller.name = value,
                    validator: Validators.required('Name can\'t be empty'),
                    decoration: InputDecoration(
                      hintText: 'Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    autocorrect: true,
                    keyboardType: TextInputType.number,
                    onSaved: (value) => controller.phone = value,
                    validator: Validators.compose([
                      Validators.required('mobile number can\'t be empty'),
                      // Validators.min(8, 'Please enter a valid phone number'),
                      Validators.patternRegExp(RegExp('^01[0-2]{1}[0-9]{8}'),
                          'Enter a valid phone number'),
                      // Validators.max(14, 'Enter a valid phone number'),
                      Validators.min(11, '')
                      // Validators.max(14, 'Please enter a valid phone number'),
                    ]),
                    decoration: InputDecoration(
                      hintText: 'Mobile Number',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    onSaved: (val) => controller.email = val,
                    validator: Validators.compose([
                      Validators.required('email is required'),
                      Validators.email('Invalid Email Address')
                    ]),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email Address',
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
                      Validators.minLength(6, 'Please enter 6 characters or more.'),
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
              Get.to(LoginScreen());
            },
            child: Text('Already have an account ? Login'),
          ),
          SizedBox(
            height: 25,
          ),
          Obx(() {
            if (controller.loading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: RaisedButton(
                  onPressed: () {
                    if (_form.currentState.validate()) {
                      _form.currentState.save();
                      controller.createAccount();
                    }
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.blue,
                ),
              );
          }),
        ],
      ),
    );
  }

  // Row buildRadioButtons() {
  //   return Row(
  //     children: [
  //       Radio(
  //           value: 0,
  //           groupValue: radioValue,
  //           onChanged: _handleRadioValueChanged),
  //       Text('Mr.'),
  //       SizedBox(
  //         width: 50,
  //       ),
  //       Radio(
  //           value: 1,
  //           groupValue: radioValue,
  //           onChanged: _handleRadioValueChanged),
  //       Text('Mrs.'),
  //       SizedBox(
  //         width: 50,
  //       ),
  //       Radio(
  //           value: 2,
  //           groupValue: radioValue,
  //           onChanged: _handleRadioValueChanged),
  //       Text('Ms.'),
  //     ],
  //   );
  // }
}
