// ignore_for_file: prefer_collection_literals, unnecessary_this, unnecessary_new

import 'package:shippingcart/model/product_model.dart';

class CartDataModel {
  List<CartModel>? data;
  CartDataModel({this.data});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data!.map((e) => e.toJson()).toList();
    return data;
  }

  factory CartDataModel.fromJson(Map<String, dynamic> json) {
    return CartDataModel(
        data:
            (json['data'] as List).map((e) => CartModel.fromJson(e)).toList());
  }
}

class CartModel {
  int? id;
  int? qty;
  double? totalPrice;
  Prices? price;
  ProductModel? product;
  CartModel({this.id, this.qty, this.totalPrice, this.price, this.product});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['qty'] = this.qty;
    data['total_price'] = this.totalPrice;
    data['product'] = this.product!.toJson();
    data['price'] = this.price!.toJson();
    return data;
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
        id: json['id'],
        qty: json['qty'] ?? 0,
        totalPrice: json['total_price'],
        price: Prices.fromJson(json['price']),
        product: ProductModel.fromJson(json['product']));
  }
}
