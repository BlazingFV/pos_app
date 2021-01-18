import 'package:get/get.dart';
import 'package:pos_app/controllers/addresses_controller.dart';
import 'package:pos_app/controllers/auth_controller.dart';
import 'package:pos_app/controllers/categories_controller.dart';
import 'package:pos_app/controllers/check_out_controller.dart';
import 'package:pos_app/controllers/user_controller.dart';

class Binding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AuthModel());
    Get.lazyPut(() => CheckOutController());
    Get.lazyPut(() => AddressesController());
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => CategoriesController());
  }

}