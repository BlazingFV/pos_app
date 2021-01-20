import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/controllers/addresses_controller.dart';

import 'package:pos_app/controllers/user_controller.dart';

class EditAddressScreen extends StatefulWidget {
  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
 final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _editAddressformData = {};
  final Map<String, dynamic> testt = {};

  String initialValue = "test";
  String newValue;

  List<String> edited = [];
  final controller = Get.put(AddressesController());
  var selected = false;

  @override
  Widget build(BuildContext context) {
    // controller.selected(false);

    final controllerss = Get.put(UserController());
    String valuee;
    

    return Scaffold(body: Obx(() {
      controller.getAreas();
      if (controllerss.userLoading.value || controller.addressLoading.value)
        return Center(
          child: CircularProgressIndicator(),
        );
      else
        return Form(
          key: _formKey,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: SingleChildScrollView(
              child: GetX<AddressesController>(
                init: AddressesController(),
                initState: (_) {},
                builder: (_) {
                  return controller.addressLoading.value
                      ? ''
                      : Column(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            buildBuildingNoTextField('', (value) {
                              _editAddressformData['BuildingNo'] = value;
                            }),

                            buildRowNoTextField('', (value) {
                              _editAddressformData['RowNo'] = value;
                            }),
                            buildFlatNoTextField('', (value) {
                              _editAddressformData['FlatNo'] = value;
                            }),
                            buildStreetTextField('', (value) {
                              _editAddressformData['Street'] = value;
                            }),

                            //   buildAreaNoTextField('PhSerial', (value) {
                            //   _editAddressformData['PhSerial'] = value;
                            // }),
                            buildPhoneTextField((value) {
                              _editAddressformData['PhSerial'] = value;
                            }),
                            // controller.sectionsLoading.value
                            //     ? Text('')
                            //     : buildareasTextField((value) {
                            //         setState(() {
                            //           _editAddressformData['AreaNo'] = value;
                            //           controller.sectionId = value;
                            //           newValue = value;
                            //           // print(controller.sectionId);
                            //           controller.getAreas();
                            //           selected = true;
                            //         });
                            //       }, () {
                            //         setState(() {
                            //           selected = false;
                            //           controller.sectionId =
                            //               _editAddressformData['AreaNo'];
                            //           controller.getAreas();
                            //         });
                            //       }),
                            // selected
                            //     ? Container(
                            //         width: 400,
                            //         height: 80,
                            //         child: buildSectionsTextField(
                            //             (value) {}, true))
                            //     : Text(''),

                            Container(
                              margin: EdgeInsets.only(top: 15),
                              width: double.infinity,
                              child: RaisedButton(
                                child: Text('Save'),
                                textColor: Colors.white,
                                color: Theme.of(context).primaryColor,
                                onPressed: () {
                                  print(_editAddressformData);
                                  if (!_formKey.currentState.validate()) {
                                    return;
                                  }
                                  _formKey.currentState.save();
                                  controller.editAddress(_editAddressformData);
                                  
                                },
                              ),
                            ),
                          ],
                        );
                },
              ),
            ),
          ),
        );
    }));
  }

  Widget buildRowNoTextField(value, onChanged) {
    var onSavedFunc = value == "" ? onChanged : (value) {};
    var onChangedFunc = value == "" ? (value) {} : onChanged;

    return TextFormField(
      decoration: InputDecoration(labelText: ' RowNo'),
      initialValue: value,
      autovalidateMode: AutovalidateMode.always,
      validator: (String value) {
        // if (value.trim().length <= 0) {
        if (value.isEmpty) {
          return 'RowNo is required ';
        } else {
          return null;
        }
      },
      onSaved: onSavedFunc,
      onChanged: onChangedFunc,
    );
  }

  // Widget buildCityTextField2(selected, cities, onSaved) {
  //   return Container(
  //     color: Colors.white,
  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
  //     child: DropDownFormField(
  //       titleText: 'المدينة',
  //       hintText: 'Please choose one',

  //       validator: (value) {
  //         // if (value.trim().length <= 0) {
  //         if (value == null) {
  //           return 'City is required.';
  //         } else {
  //           return null;
  //         }
  //       },
  //       // value: selected,
  //       onSaved: onSaved,
  //       // value:{
  //       //       "display": "cairo",
  //       //       "value": "1",
  //       //     },

  //       // dataSource: [{"display":"as" , "value":"calue"}],
  //       // dataSource: cities.map(
  //       //   (city) {
  //       //     return {
  //       //       "display": city.name,
  //       //       "value": city.id,
  //       //     };
  //       //   },
  //       // ).toList(),

  //       textField: 'display',
  //       valueField: 'value',
  //       value: selected,
  //     ),
  //   );
  // }

  Widget buildPhoneTextField(onchanged) {
    final controllerss = Get.find<UserController>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField(
        value: controllerss.old,
        onChanged: onchanged,
        items: controllerss.user.phones.map((phone) {
          var i = controllerss.phones.indexOf(phone) ;
          return DropdownMenuItem<String>(
              child: Text(controllerss.user.phones[i]['phone'].toString()),
            value: controllerss.user.phones[i]['id'].toString(),
          );
        }).toList(),
        decoration: InputDecoration(
          hintText:
              controllerss.user.phones != null ? 'Mobile Phones' : 'loading',
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

  Widget buildareasTextField(onchanged, onTap) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField(
        value: controller.oldValue,
        onChanged: onchanged,
        onTap: onTap,
        items: controller.areas.map((area) {
          controller.getAreas();
          
          return DropdownMenuItem<String>(
            child: Text('${area.areaName}'),
            value: "${area.id}",
          );
        }).toList(),
        decoration: InputDecoration(
          hintText: controller.areas != null ? 'Areas' : 'loading',
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

  Widget buildSectionsTextField(onchanged, bool chance) {
    return (chance)
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField(
              onChanged: (value){
               

                setState(() {
                  value = newValue;
                });
              },
              onTap: (){
                setState(() {
                  controller.sectionId = newValue;
                });
              },
              items: controller.sections.map((section) {
                WidgetsBinding.instance.addPostFrameCallback((_) {});
                return DropdownMenuItem<String>(
                  child: Text('${section.areaName}'),
                  value: controller.sectionId,
                );
              }).toList(),
              decoration: InputDecoration(
                hintText: controller.areas != null ? 'Areas' : 'loading',
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
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField(
              onChanged: (value){
                print(value);
                setState(() {
                  
                });
              },
              onTap: (){
                setState(() {
                  
                });
              },
              items: controller.sections.map((section) {
                return DropdownMenuItem<String>(
                  child: Text('${section.areaName}'),
                  value: controller.sectionId,
                );
              }).toList(),
              decoration: InputDecoration(
                hintText: controller.areas != null ? 'Areas' : 'loading',
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
            ));
  }

  Widget buildBuildingNoTextField(value, onSaved) {
    return TextFormField(
        decoration: InputDecoration(labelText: 'BuildingNo'),
        initialValue: value,
        autovalidateMode: AutovalidateMode.always,
        validator: (String value) {
          // if (value.trim().length <= 0) {
          if (value.isEmpty) {
            return 'BuildingNo is required.';
          } else {
            return null;
          }
        },
        onSaved: onSaved);
  }

  Widget buildFlatNoTextField(value, onSaved) {
    return TextFormField(
        decoration: InputDecoration(labelText: 'FlatNo'),
        initialValue: value,
        autovalidateMode: AutovalidateMode.always,
        validator: (value) {
          // if (value.trim().length <= 0) {
          if (value.isEmpty) {
            return 'FlatNo is required.';
          } else {
            return null;
          }
        },
        onSaved: onSaved);
  }

  Widget buildStreetTextField(value, onSaved) {
    return TextFormField(
        decoration: InputDecoration(labelText: 'Street'),
        initialValue: value,
        autovalidateMode: AutovalidateMode.always,
        validator: (value) {
          // if (value.trim().length <= 0) {
          if (value.isEmpty) {
            return 'Street is required.';
          } else {
            return null;
          }
        },
        onSaved: onSaved);
  }
}