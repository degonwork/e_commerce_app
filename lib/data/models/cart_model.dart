import 'package:e_commerce_app_getx/data/models/product_model.dart';

class Cart {
  final int? id;
  final String? title;
  final num? price;
  final String? image;
  int? quantity;
  bool? isExit;
  String? time;
  final Product? product;

  Cart({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.quantity,
    this.isExit,
    this.time,
    required this.product,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      image: json['image'],
      quantity: json['quantity'],
      isExit: json['isExit'],
      time: json['time'],
      product: Product.fromJson(
        json['product'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'title': this.title,
      'price': this.price,
      'image': this.image,
      'quantity': this.quantity,
      'isExit': this.isExit,
      'time': this.time,
      'product': this.product!.toJson(),
    };
  }
}
