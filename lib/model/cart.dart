class Cart {
  final int id;
  final int userId;
  final String date;
  final List<ProductCartItem> products;

  Cart({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      userId: json['userId'],
      date: json['date'],
      products: (json['products'] as List)
          .map((item) => ProductCartItem.fromJson(item))
          .toList(),
    );
  }
}

class ProductCartItem {
  final int productId;
  final int quantity;
  String name;
  String image;

  ProductCartItem({
    required this.productId,
    required this.quantity,
    this.name = '',
    this.image = '',
  });

  factory ProductCartItem.fromJson(Map<String, dynamic> json) {
    return ProductCartItem(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }
}



