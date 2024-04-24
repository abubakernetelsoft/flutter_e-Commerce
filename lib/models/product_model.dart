

class ProductModel{
  int id;
  String title;
  String description;
  String image;
  num  price;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "image": image,
    "price": price,
  };

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
  });
}