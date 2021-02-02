import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pos_app/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductController extends GetxController {
  var productLoading = false.obs;
  var priceFrom;
  var priceTo;
  var groupCode;
  var search;
  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  Product product = Product();

  getProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String url = 'http://nozomecom.esolve-eg.com/api/product';
    productLoading(true);
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json'
        },
      );

      print(response.body);
      if (response.statusCode == 200) {
        final testProduct = Product.fromJson(response.body);
        product = testProduct;
        print(product);
        // print('$adresses sss');
        update();
        productLoading(false);
      }
    } catch (e) {
      //
    }
  }

  getProductsQuery() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String sss = '/api/product';
    Map<String, String> queryParams = {
      'PriceFrom': priceFrom,
      'PriceTo': priceTo,
      // 'GroupCode': groupCode,
      // 'Search': search,
    };
    var uri = Uri.http('nozomecom.esolve-eg.com', sss, queryParams);
    print(uri);
    productLoading(true);
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
        final filteredProducts = Product.fromJson(response.body);
        print(response.body);
        print(filteredProducts);
        product = filteredProducts;
        productLoading(false);
        update();
      }
    } catch (e) {}
  }

  getProductsQuerySearch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String sss = '/api/product';
    Map<String, String> queryParams = {
      'Search': search,
    };
    var uri = Uri.http('nozomecom.esolve-eg.com', sss, queryParams);
    print(uri);
    productLoading(true);
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
        final filteredProducts = Product.fromJson(response.body);
        print(response.body);
        print(filteredProducts);
        product = filteredProducts;
        productLoading(false);
        update();
      }
    } catch (e) {}
  }
}
