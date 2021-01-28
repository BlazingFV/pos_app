import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/controllers/user_controller.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class ProfileScreen extends GetWidget<UserController> {
  final _form = GlobalKey<FormState>();
  final UserController controllerss = Get.put(UserController());
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _attachPhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // _nameController.selection = _nameController.selection.copyWith(
    //     baseOffset: controller.userName.length,
    //     extentOffset: controller.userName.length);
    // _emailController.selection = _emailController.selection.copyWith(
    //     baseOffset: controller.userEmail.length,
    //     extentOffset: controller.userEmail.length);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text('My Profile'),
        ),
        body: Obx(() {
          if (controllerss.userLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else
            return Form(
              key: _form,
              child: ListView(
                children: [
                  buildDetailsListTile(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                    child: Text('Name'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _nameController,
                      onSaved: (value) => controller.userName = value,
                      validator: Validators.required('name cannot be empty'),
                      decoration: InputDecoration(
                        labelText: 'Name',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                    child: Text('Mobile Phone'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _phoneController,
                      onSaved: (value) => controller.mobilePhone = value,
                      validator: Validators.compose([
                        Validators.required('Phone Number is Required'),
                        Validators.min(11, 'Please enter a valid phone number')
                      ]),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: Icon(Icons.edit), onPressed: () {}),
                        labelText: '',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                    child: Text('E-Mail'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _emailController,
                      onSaved: (value) => controller.userEmail = value,
                      validator: Validators.compose([
                        Validators.required('email is required'),
                        Validators.email('Invalid Email Address')
                      ]),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                  Obx(() {
                    if(!controller.showTextForm.value)
                    return Text('');
                    else
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _attachPhoneController,
                        onSaved: (value) => controller.attachNPhone = value,
                        validator: Validators.compose([
                          Validators.required('Phone Number is Required'),
                          Validators.min(
                              11, 'Please enter a valid phone number')
                        ]),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(Icons.edit), onPressed: () {}),
                          labelText: 'Add A New Phone',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 55,
                      child: RaisedButton(
                        onPressed: () {
                          if (_form.currentState.validate()) {
                            _form.currentState.save();
                            controller.updateUser();
                            controller.updatePhone();
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35)),
                        color: Colors.blue,
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 55,
                      child: RaisedButton(
                        onPressed: () {
                          controller.showTextForm.value = true;
                            controller.attachPhone();
                            if (_form.currentState.validate()) {
                            _form.currentState.save();
                           
                            // controller.updateUser();
                            // controller.updatePhone();
                          }
                          print(controller.showTextForm);
                           _attachPhoneController.clear();
                           controller.showTextForm.value = false;
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35)),
                        color: Colors.blue,
                        child: Text(
                          'Add a New Phone',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
        }));
  }

  ListTile buildDetailsListTile() {
      // var i = controller.phones.indexOf('phone');
    _nameController.text = controller.userC.user.name;
    _emailController.text = controller.userC.user.email;
    _phoneController.text = controller.phones[0];
    return ListTile(
      title: Text(
        'Your Details',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: Text(
          'Here you can edit you personal details. When you\'re done, click save.',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
