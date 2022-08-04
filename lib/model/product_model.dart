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
  factory Prices.fromJson(Map<String, dynamic> json) => Prices(
        id: json['id'],
        name: json['name'],
        price: json['price'],
      );
}
