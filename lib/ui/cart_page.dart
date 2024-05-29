import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/cart_controller.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CartPage extends StatelessWidget {
  final CartController cartController = Get.put(CartController());
double totalHarga = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                                     var tot = product?['price']*item.quantity;
                                     cart.products.forEach((item) {
                                      var product = snapshot.data;
                                      double hargaProduk = product?['price'].toDouble() * item.quantity;
                                      totalHarga += hargaProduk;
                                    });
                                    return Column(
                                      children: [
                                            Container(
                                            width: double.infinity,
                                            height: 1, 
                                            color: Colors.grey, 
                                            margin: EdgeInsets.symmetric(vertical: 20), 
                                          ),
                                        Row(
                                          children: [
                                             SizedBox(height: 50),
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
                                                  Text('Total: \$${product?['price']} x ${item.quantity} = \$${tot}',style: TextStyle(color: Colors.green),),
                                                ],
                                              ),
                                            ),
                                          ],
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
