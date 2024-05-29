class Cart {
  final int id;
  final int userId;
  final String date;
  final List<CartItem> products;

  Cart({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    List<CartItem> products = (json['products'] as List)
        .map((item) => CartItem(productId: item['productId'], quantity: item['quantity']))
        .toList();

    return Cart(
      id: json['id'],
      userId: json['userId'],
      date: json['date'],
      products: products,
    );
  }
}
class CartItem {
  final int productId;
  final int quantity;

  CartItem({
    required this.productId,
    required this.quantity,
  });
}
