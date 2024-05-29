import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/products.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productList = <Product>[].obs;
  var selectedProduct = Product().obs;
    var filteredProducts = <Product>[].obs;
    var searchQuery = ''.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        var products = json.decode(response.body) as List;
        productList.value = products.map((product) => Product.fromJson(product)).toList();
      }
    } finally {
      isLoading(false);
    }
  }

  void fetchProductById(int id) async {
    try {
      await Future.delayed(Duration.zero);
      isLoading(true);
      var response = await http.get(Uri.parse('https://fakestoreapi.com/products/$id'));
      if (response.statusCode == 200) {
        var product = json.decode(response.body);
        selectedProduct.value = Product.fromJson(product);
      }
    } finally {
      isLoading(false);
    }
  }

  void filterProducts(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredProducts.value = productList;
    } else {
      filteredProducts.value = productList
          .where((product) => product.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
