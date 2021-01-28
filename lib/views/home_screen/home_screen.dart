import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/controllers/product_controller.dart';
import 'package:pos_app/views/home_screen/widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

ProductController controller = Get.put(ProductController());

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: TextFormField(
            onChanged: (value){
              controller.search = value;
            },
            decoration: InputDecoration(
              hintText: 'Search for a Product',
              suffixIcon: InkWell(onTap:(){
              controller.getProductsQuery();
              },child: Icon(Icons.search)),
            ),
          ),
        ),
        body: Obx(() {
          if (controller.productLoading.value)
            return Center(child: CircularProgressIndicator());
          else
            return GetBuilder<ProductController>(
              init: ProductController(),
              initState: (_) {},
              builder: (cont) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: 400,
                        height: 185,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: home(),
                        ),
                      ),
                      Container(
                        width: 400,
                        height: 185,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: home(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (value) {
                            controller.priceFrom = value;
                          },
                          keyboardType: TextInputType.number,
                          decoration:
                              InputDecoration(hintText: 'Price from filter'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (value) {
                            controller.priceTo = value;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Price to filter',
                          ),
                        ),
                      ),
                          Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (value) {
                            controller.groupCode= value;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'GroupCode',
                          ),
                        ),
                      ),
                      RaisedButton(
                          onPressed: () {
                            controller.getProductsQuery();
                            
                          },
                          child: Text('Filter'))
                    ],
                  ),
                );
              },
            );
        }));
  }

  home() {
    return controller.product.data.map((data) {
      return Container(
        width: 150,
        height: 130,
        child: Column(
          children: [
            Container(
                color: Colors.grey[100],
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.11,
                child: Image(image: NetworkImage(data.itemImage))),
            Container(
                width: 80, height: 35, child: Text('Name ${data.itemName}')),
            Container(
                width: 80, height: 35, child: Text('Price:${data.pospp}')),
            // Container(width: 150, height:85,child: Text('${}')),
          ],
        ),
      );
    }).toList();
  }
}
