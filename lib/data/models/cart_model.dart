class Cart {
  final int? id;
  final String? title;
  final num? price;
  final String? image;
  int? quantity;
  bool? isExit;
  String? time;

  Cart({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.quantity,
    this.isExit,
    this.time,
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
    );
  }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title; Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['price'] = this.price;
//     data['description'] = this.description;
//     data['category'] = this.category;
//     data['image'] = this.image;
//     if (this.rating != null) {
//       data['rating'] = this.rating!.toJson();
//     }
//     return data;
//   }
// }
}
