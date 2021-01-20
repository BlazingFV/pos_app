import 'dart:convert';

import 'package:get/get.dart';
import 'package:pos_app/controllers/auth_controller.dart';
import 'package:pos_app/models/phones.dart';
import 'package:pos_app/models/user.dart';
import 'package:pos_app/views/auth_screens/login_screen.dart';
import 'package:pos_app/views/home_screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  String userName, userEmail, userPassword, mobilePhone, attachNPhone;
  var userLoading = false.obs;
  User user = User();
  List<dynamic> phones;
  String old;
  var showTextForm = false.obs;

  void onInit() {
    // autoAuthenticate();
    super.onInit();
  }


  getUser(token) async {
    String url = 'http://nozomecom.esolve-eg.com/api/user';
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print('$token');
    userLoading(true);
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    final extractedData = jsonDecode(response.body);
    print(response.body);
    if (extractedData == null) {
      return;
    }
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      user = User(
        id: responseData['id'],
        name: responseData['name'],
        accSerial: responseData['accSerial'],
        address: responseData['address'],
        createdAt: responseData['createdAt'],
        email: responseData['email'],
        phones: responseData['phones'],
      );
      print(responseData['phones']);
      phones = responseData['phones'];
      print(user.phones);
      userLoading(false);
    }

    return user;
  }

  attachPhone() async {
    String url = 'http://nozomecom.esolve-eg.com/api/user/phone';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String responsebodyy = '';
    userLoading(true);
    print('$attachNPhone');
    final Map<String, dynamic> body = {
      "phone": attachNPhone,
    };
    try {
      final response = await http.post(
        url,
        body: body,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      Get.snackbar('Processing', response.body.toString());
      responsebodyy = response.body.toString();
      print(response.body);
      attachNPhone = '';
      userLoading(false);

      // showTextForm(false);
    } catch (e) {
      Get.snackbar('Error', responsebodyy);
      userLoading(false);
    }
  }

  updatePhone() async {
    String url = 'http://nozomecom.esolve-eg.com/api/user/phone/1';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    userLoading(true);
    print('$mobilePhone');
    final Map<String, dynamic> body = {
      "phone": mobilePhone,
    };
    final response = await http.put(
      url,
      body: body,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    Get.snackbar('sss', response.body);
    print(response.body);
    userLoading(false);
  }

  updateUser() async {
    String url = 'http://nozomecom.esolve-eg.com/api/user';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    userLoading(true);
    print('${userName} ${userEmail}');
    // final body = json.encode({
    //   "email": userEmail.trim(),
    //   "name": userName.trim(),
    // });
    final Map<String, dynamic> body = {
      "name": userName,
      "email": userEmail,
    };
    final response = await http.put(
      url,
      body: body,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    Get.snackbar('sss', response.body);
    print(response.body);
    userLoading(false);
    getUser(token);
  }

  void autoAuthenticate() async {
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (token != null) {
      getUser(token);
      Get.to(LoginScreen());
      Future.delayed(Duration(milliseconds: 2000), () {
      
        Get.to(HomeScreen());
      });
    } else {
      Get.to(LoginScreen());
    }
  }

//  List<User> fromAreaJsonArray(response) {
//     final parsed = json.decode(response).cast<Map<String, dynamic>>();
//     return parsed.map<User>((json) => Area.fromJson(json)).toList();
//   }
}
