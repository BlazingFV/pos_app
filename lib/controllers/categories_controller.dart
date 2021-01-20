import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pos_app/models/categories.dart';
import 'package:pos_app/models/sub_category.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CategoriesController extends GetxController {
  var catLoading = false.obs;
  var selected = false.obs;
  List<Categories> categories = [];
  List<SubCategory> subCat = [];
  String oldValue ;
  SubCategory subCategories = SubCategory();
 
  String catId = '';
  @override
  void onInit() {
    getCategories();
    getSubCategories();
    super.onInit();
  }

  getCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String sss = 'api/group/list';
    Map<String, String> queryParams = {
      'FatherCode': catId,
    };
    var uri = Uri.http('nozomecom.esolve-eg.com', sss, queryParams);
    catLoading(true);
    try {
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8'
      });

      if (response.statusCode == 200) {
        // print('$responseData');
        List<Categories> loadedCategories =
            fromCategoriesJsonArray(response.body);
        print(response.body);

        categories = loadedCategories;
        print(categories);
        update();
        catLoading(false);
      }
    } catch (e) {
      print(e.message.toString());
    }
  }

  getSubCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String url = 'http://nozomecom.esolve-eg.com/api/group/find/$catId';
    print(url);
    catLoading(true);
    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8'
      });
      if (response.statusCode == 200) {
        // print('$responseData');
       final loadedSubCategories = subCategoryFromMap(response.body);
           subCategories = loadedSubCategories;
        print(response.body);
        subCat.add(subCategories);
        subCategories = loadedSubCategories;
        print(subCat);
        update();
        catLoading(false);
      }
    } catch (e) {
      print(e.toString());
      catLoading(false);
    }
  }

  List<Categories> fromCategoriesJsonArray(response) {
    final parsed = json.decode(response).cast<Map<String, dynamic>>();
    return parsed.map<Categories>((json) => Categories.fromJson(json)).toList();
  }
   List<SubCategory> fromSubsCategoriesJsonArray(response) {
    final parsed = json.decode(response);
    return parsed.map<SubCategory>((json) => SubCategory.fromMap(json)).toList();
  }


}
