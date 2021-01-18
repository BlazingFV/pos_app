import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/controllers/addresses_controller.dart';
import 'package:pos_app/models/addresses.dart';
import 'package:pos_app/views/user_screens/add_address.dart';
import 'package:pos_app/views/user_screens/edit_address.dart';

class AddressesScreen extends GetWidget<AddressesController> {
  final AddressesController controllerss = Get.put(AddressesController());
  Addresses address = Addresses();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Addresses"),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => AddAddress()));
              }),
        ],
      ),
      body: Obx(() {
        if (controllerss.addressLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.adresses.length < 1) {
          return Center(
            child: Text(
              'You Don\'t have any addresses yet !',
              style: TextStyle(
                fontSize: 23,
              ),
            ),
          );
        } else {
          return Obx(() {
            return ListView.builder(
              itemBuilder: (context, index) {
                return showAddresses(context);
              },
              itemCount: controller.adresses.length,
            );
          });
        }
      }),
    );
  }

  Widget showAddresses(context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        width: MediaQuery.of(context).size.width * 87,
        height: MediaQuery.of(context).size.height * 65,
        child: ListView(
          children: controller.adresses.map((address) {
             controller.addressId =address.id.toString();
           return Card(
              elevation: 5,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(' Street: '),
                      Text('${address.street}'),
                    ],
                  ),
                  Row(
                    children: [
                      Text(' FlatNo: '),
                      Text('${address.flatNo}'),
                    ],
                  ),
                  Row(
                    children: [
                      Text(' BuildingNo: '),
                      Text('${address.buildingNo}'),
                    ],
                  ),
                  Row(
                    children: [
                      Text(' RowNo: '),
                      Text('${address.rowNo}'),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Get.to(EditAddressScreen());
                        }),
                  ),
                     Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        icon: Icon(Icons.delete,color:Colors.red),
                        onPressed: () {
                         controller.deleteAddress();
                        }),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
