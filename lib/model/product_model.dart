// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class ProductDataModel {
  List<ProductModel>? data;
  ProductDataModel({this.data});
  factory ProductDataModel.fromJson(Map<String, dynamic> json) =>
      ProductDataModel(
          data: json['data'] == null || json['data'] == []
              ? []
              : (json['data'] as List)
                  .map((e) => ProductModel.fromJson(e))
                  .toList());
}

class ProductModel {
  int? id;
  String? name;
  String? image;
  String? description;
  List<Prices>? price;
  ProductModel({this.id, this.name, this.description, this.image, this.price});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['prices'] = this.price!.map((e) => e.toJson()).toList();
    return data;
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
      price: json['prices'] == null || json['prices'] == []
          ? []
          : (json['prices'] as List).map((e) => Prices.fromJson(e)).toList());
}

class Prices {
  int? id;
  String? name;
  double? price;
  Prices({this.id, this.name, this.price});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    return data;
  }

  factory Prices.fromJson(Map<String, dynamic> json) => Prices(
        id: json['id'],
        name: json['name'],
        price: json['price'],
      );
}
