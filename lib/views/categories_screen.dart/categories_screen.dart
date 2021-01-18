import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/controllers/categories_controller.dart';

class CategoriesScreen extends GetWidget<CategoriesController> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: TextFormField(
          decoration: InputDecoration(
            hintText: 'Search for a Product',
            suffixIcon: Icon(Icons.search),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.88,
              width: 80,
              child: ListView.builder(
                  itemCount: controller.categories.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(6),
                      child: Text('${controller.categories}'),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
