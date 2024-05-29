import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/cart_controller.dart';

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
                        .map((item) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: [
                                  Image.network(
                                    item.image,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item.name),
                                      Text('Quantity: ${item.quantity}'),
                                    ],
                                  ),
                                ],
                              ),
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
}
