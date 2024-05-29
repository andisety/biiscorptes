import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/cart_controller.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CartPage extends StatelessWidget {
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: Obx(() {
        if (cartController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: cartController.cartList.length,
            itemBuilder: (context, index) {
              var cart = cartController.cartList[index];
              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text('Cart ID: ${cart.id}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: cart.products
                        .map((item) => FutureBuilder(
                              future: getProductDetails(item.productId),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else {
                                  if (snapshot.hasError) {
                                    return Text('Error');
                                  } else {
                                    var product = snapshot.data;
                                    return Row(
                                      children: [
                                         SizedBox(height: 70),
                                        Image.network(
                                          product?['image'],
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(product?['title']),
                                              Text('Quantity: ${item.quantity}'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                }
                              },
                            ))
                        .toList(),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }

  Future<Map<String, dynamic>> getProductDetails(int productId) async {
    var response = await http.get(Uri.parse('https://fakestoreapi.com/products/$productId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load product');
    }
  }
}
