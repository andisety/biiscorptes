class Product {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;

  Product({
    this.id = 0,
    this.title = '',
    this.price = 0.0,
    this.description = '',
    this.category = '',
    this.image = '',
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
    );
  }
}
