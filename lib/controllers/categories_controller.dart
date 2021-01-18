import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pos_app/models/categories.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CategoriesController extends GetxController {
  List<Categories> categories = [];
  @override
  void onInit() {
    getCategories();
    super.onInit();
  }

  getCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String url = 'http://nozomecom.esolve-eg.com/group/list';

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    });
    

 
    if (response.statusCode == 200) {
      
      // print('$responseData');
      List<Categories> loadedCategories = fromCategoriesJsonArray(response.body);
      
      categories = loadedCategories;
      print(categories);
    }
  }

  List<Categories> fromCategoriesJsonArray(response) {
    final parsed = json.decode(response).cast<Map<String, dynamic>>();
    return parsed.map<Categories>((json) => Categories.fromJson(json)).toList();
  }
}
