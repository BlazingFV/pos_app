import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/controllers/categories_controller.dart';
import 'package:pos_app/controllers/product_controller.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  CategoriesController controller = Get.put(CategoriesController());
  ProductController cont = Get.put(ProductController());
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
      body: Obx(() {
        if (controller.catLoading.value)
          return Center(
            child: CircularProgressIndicator(),
          );
        else
          return ListView(
            children: [
              controller.selected.value
                  ? buildSubCategoryTextField()
                  : Text(''),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.20,
                  width: 80,
                  child: GetBuilder<CategoriesController>(
                    init: CategoriesController(),
                    initState: (_) {},
                    builder: (value) {
                      return ListView(
                        children: value.categories.map((category) {
                          // value.getCategories();
                          return GestureDetector(
                              onTap: () {
                                print(category.groupName);
                                controller.catId = category.id.toString();
                                print(controller.catId);
                                value.getSubCategories();
                                controller.selected(true);
                              },
                              child: Text('${category.groupName}'));
                        }).toList(),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
      }),
    );
  }

  Widget buildSubCategoryTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField(
        value: controller.oldValue,
        onChanged: (value) {
          controller.oldValue = value;
        },
        items: controller.subCategories.groups.map(
          (subCat) {
            cont.getProducts();
            return DropdownMenuItem<String>(
              child: Text('${subCat.groupName}'),
              value: '${subCat.id}',
            );
          },
        ).toList(),
        decoration: InputDecoration(
          hintText: controller.subCat != null ? 'SubCategories' : 'loading',
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
    );
  }
}
