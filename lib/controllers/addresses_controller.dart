import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/controllers/user_controller.dart';
import 'package:pos_app/models/addresses.dart';
import 'package:pos_app/models/area.dart';
import 'package:pos_app/models/findAddress.dart';
import 'package:pos_app/views/user_screens/addresses_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddressesController extends GetxController {
  var adresses = List<Addresses>().obs;
  var fiindAddresses = [];
  FindAddress findAddress = FindAddress();
  var areas = List<Area>();
  var sections = List<Area>();
  var selected = false.obs;
  bool areaSelc = false;
  var addressLoading = false.obs;
  var areaLoading = false;
  var sectionsLoading = false.obs;
  var sectionId = '';
  var addressId = '';
  var rowNo = '';
  var street = '';
  var flatNo = '';
  var buildingNo = '';
  String oldValue;
  @override
  void onInit() {
    getAreas();
    getAddresses();
    getSections();
    super.onInit();
  }

  editAddress(formData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String url = 'http://nozomecom.esolve-eg.com/api/address/$addressId';
    // addressLoading(true);
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json'
        },
        body: jsonEncode(formData),
      );
      print(response.body);
      if (response.statusCode == 200) {
        String responseMsg = "Address Added Successfully";
        // Get.snackbar('Success', responseMsg,
        //     snackPosition: SnackPosition.BOTTOM,
        //     colorText: Colors.white,
        //     backgroundColor: Colors.black);
        Future.delayed(Duration(milliseconds: 1000), () {
          print(response.body);
          getAddresses();
          Get.off(AddressesScreen());
        });

        update();
      } else {
        // Get.snackbar('error', response.body);
        // print(response.body);
      }
    } catch (e) {
      Get.snackbar('error', e.message);
      print(e.message);
    }
  }

  addAddresses(formData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String url = 'http://nozomecom.esolve-eg.com/api/address';
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json'
        },
        body: jsonEncode(formData),
      );
      // print(response.body);
      if (response.statusCode == 200) {
        String responseMsg = "Address Added Successfully";
        Get.snackbar('Success', responseMsg);
        getAddresses();
        Future.delayed(Duration(milliseconds: 1000), () {
          Get.off(AddressesScreen());
        });
        print(response.body);
        update();
      } else {
        Get.snackbar('error', response.body);
        print(response.body);
      }
    } catch (e) {
      Get.snackbar('error', e.message);
      print(e.message);
    }
  }

  getSections() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String url = 'http://nozomecom.esolve-eg.com/api/area/list';
    sectionsLoading(true);
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        List<Area> loadedAreas = fromAreaJsonArray(response.body);
        areas = loadedAreas;
        // print(response.body);
        // print('$areas');
        sectionsLoading(false);
        update();
      }
    } catch (e) {}
  }

  getAddresses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String url = 'http://nozomecom.esolve-eg.com/api/address/list';
    addressLoading(true);
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json'
        },
      );
      // print(response.body);
      if (response.statusCode == 200) {
        List<Addresses> loadedAddresses = fromAddressesJsonArray(response.body);
        adresses.assignAll(loadedAddresses);
        print(response.body);
        // print('$adresses sss');
        update();
        addressLoading(false);
      }
    } catch (e) {
      //
    }
  }

  findAddresses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String url = 'http://nozomecom.esolve-eg.com/api/address/find/$addressId';
    addressLoading(true);
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json'
        },
      );
      // print(response.body);

      if (response.statusCode == 200) {
        final loadedFindAdd = FindAddress.fromJson(response.body);
        findAddress = loadedFindAdd;
        print(response.body);
        fiindAddresses.add(findAddress);
        findAddress = loadedFindAdd;
        print(fiindAddresses);
        update();
        addressLoading(false);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  deleteAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String url = 'http://nozomecom.esolve-eg.com/api/address/$addressId';
    addressLoading(true);
    try {
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json'
        },
      );
      // print(response.body);
      if (response.statusCode == 200) {
        // List<Addresses> loadedAddresses = fromAddressesJsonArray(response.body);
        // adresses.assignAll(loadedAddresses);
        print(response.body);
        // print('$adresses sss');
        getAddresses();
        update();
        addressLoading(false);
      }
    } catch (e) {
      //
    }
  }

  getAreas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String sss = '/api/area/list'.trim();
    Map<String, String> queryParams = {
      'SectionNo': sectionId,
    };
    var uri = Uri.http('nozomecom.esolve-eg.com', sss, queryParams);
    // String url = 'http://nozomecom.esolve-eg.com/api/address/list?$queryParams';

    try {
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json'
        },
      );
      // print(uri);
      // print(response.body);
      if (response.statusCode == 200) {
        List<Area> loadedSections = fromAreaJsonArray(response.body);
        print(sectionId);
        sections = loadedSections;

        update();
      }
    } catch (e) {}
  }

  List<Addresses> fromAddressesJsonArray(response) {
    final parsed = json.decode(response).cast<Map<String, dynamic>>();
    return parsed.map<Addresses>((json) => Addresses.fromJson(json)).toList();
  }

  List<Area> fromAreaJsonArray(response) {
    final parsed = json.decode(response).cast<Map<String, dynamic>>();
    return parsed.map<Area>((json) => Area.fromJson(json)).toList();
  }
}
