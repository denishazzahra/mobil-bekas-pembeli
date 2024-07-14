class Product {
  int? id;
  String? name;
  String? tahun;
  int? harga;
  String? productImage;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Map<String, String>? user;

  Product(
      {this.id,
      this.name,
      this.tahun,
      this.harga,
      this.productImage,
      this.userId,
      this.createdAt,
      this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tahun = json['tahun'];
    harga = json['harga'];
    productImage = json['productImage'];
    userId = json['UserId'];
    createdAt = DateTime.parse(json['createdAt']);
    updatedAt = DateTime.parse(json['updatedAt']);
    user = json['User'] != null ? Map<String, String>.from(json['User']) : null;
  }
}
