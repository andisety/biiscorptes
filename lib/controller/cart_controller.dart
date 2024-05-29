import 'dart:convert';

import 'package:biiscorptes/model/cart.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

class CartController extends GetxController {
  var isLoading = true.obs;
  var cartList = <Cart>[].obs;

  @override
  void onInit() {
    fetchCarts();
    super.onInit();
  }

  void fetchCarts() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse('https://fakestoreapi.com/carts'));
      if (response.statusCode == 200) {
        var carts = json.decode(response.body) as List;
        cartList.value = carts.map((cart) => Cart.fromJson(cart)).toList();
        
        // Mengambil detail produk untuk setiap produk dalam keranjang
        for (var cart in cartList) {
          for (var product in cart.products) {
            var productResponse = await http.get(Uri.parse('https://fakestoreapi.com/products/${product.productId}'));
            if (productResponse.statusCode == 200) {
              var productData = json.decode(productResponse.body);
              product.name = productData['title'];
              product.image = productData['image'];
            }
          }
        }
      }
    } finally {
      isLoading(false);
    }
  }
}
