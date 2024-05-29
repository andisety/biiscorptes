import 'package:biiscorptes/ui/cart_page.dart';
import 'package:biiscorptes/ui/detail.dart';
import 'package:biiscorptes/ui/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'template.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Biiscorp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Template(),
      getPages: [
        GetPage(name: '/', page: () => Template()),
        GetPage(
          name: '/product_detail',
          page: () => ProductDetailPage(
            productId: int.parse(Get.parameters['productId']!),
          ),),
          GetPage(name: '/cart', page: () => CartPage()), 
          GetPage(name: '/user', page: () => UserPage()), 
      
      ],
    );
  }
}
