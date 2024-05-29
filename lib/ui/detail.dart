import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/product_controller.dart';

class ProductDetailPage extends StatefulWidget {
  final int productId;

  ProductDetailPage({required this.productId});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final ProductController productController = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productController.fetchProductById(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          var product = productController.selectedProduct.value;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: Image.network(
                      product.image,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                      return Placeholder(
                                        fallbackWidth: 50,
                                        fallbackHeight: 50,
                                      );
                                    },
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  product.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  '\$${product.price}',
                  style: TextStyle(fontSize: 20, color: Colors.green),
                ),
                SizedBox(height: 8),
                Text(product.description),
                SizedBox(height: 16),
                QuantitySelector(),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Add to cart logic here
                  },
                  child: Text('Add to Cart'),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}

class QuantitySelector extends StatefulWidget {
  @override
  _QuantitySelectorState createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            setState(() {
              if (quantity > 1) quantity--;
            });
          },
        ),
        Text(quantity.toString(), style: TextStyle(fontSize: 18)),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            setState(() {
              quantity++;
            });
          },
        ),
      ],
    );
  }
}
