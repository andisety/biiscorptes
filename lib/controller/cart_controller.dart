import 'dart:convert';

import 'package:biiscorptes/model/cart.dart';
import 'package:biiscorptes/model/user.dart';
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
      }
    } finally {
      isLoading(false);
    }
  }
}

// class CartController extends GetxController {
//   var isLoading = true.obs;
//   var cartList = <Cart>[].obs;
//   var userList = <User>[].obs; // Tambahkan daftar pengguna

//   @override
//   void onInit() {
//     fetchCarts();
//     super.onInit();
//   }

//   void fetchCarts() async {
//     try {
//       isLoading(true);
//       var response = await http.get(Uri.parse('https://fakestoreapi.com/carts'));
//       if (response.statusCode == 200) {
//         var carts = json.decode(response.body) as List;
//         cartList.value = carts.map((cart) => Cart.fromJson(cart)).toList();
        
//         for (var cart in cartList) {
//           var userResponse = await http.get(Uri.parse('https://fakestoreapi.com/users/${cart.userId}'));
//           if (userResponse.statusCode == 200) {
//             var userData = json.decode(userResponse.body);
//             var user = User.fromJson(userData);
//             userList.add(user);
//           }
//         }
//       }
//     } finally {
//       isLoading(false);
//     }
//   }
// }

