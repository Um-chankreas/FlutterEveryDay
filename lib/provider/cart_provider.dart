// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shippingcart/model/cart_model.dart';
import 'package:shippingcart/model/product_model.dart';

class CartProvider with ChangeNotifier {
  CartDataModel? _listCart;
  CartDataModel? get getCart => _listCart;
  ProductModel? product;
  _saveDataToJson() async {
    final prefs = await SharedPreferences.getInstance();
    var _json = _listCart!.toJson();
    Map _data = _json;
    prefs.setString("cart_local", jsonEncode(_data));
  }

  void getDataFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    dynamic getData = prefs.getString("cart_local");
    if (getData != null) {
      _listCart = CartDataModel.fromJson(jsonDecode(getData));
      print(_listCart!.toJson());
      notifyListeners();
    }
  }

  void clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void setCart() {
    CartDataModel cartDataModel = CartDataModel();
    _listCart = cartDataModel;
    _listCart!.data = [];
    notifyListeners();
  }

  addToCart(ProductModel? productModel) {
    int cartId = 0;
    if (_listCart!.data!.isEmpty) {
      cartId = cartId + 1;
    } else {
      if (_listCart!.data!.last.id == null) {
        cartId = cartId + 1;
      } else {
        cartId = _listCart!.data!.last.id! + 1;
      }
    }
    // print(productModel!.toJson());
    CartModel cartModel = CartModel(
        id: cartId,
        qty: 1,
        totalPrice: productModel!.price!.first.price,
        price: productModel.price![0],
        product: productModel);
    _listCart!.data!.add(cartModel);

    notifyListeners();
    _saveDataToJson();
  }

  increaseCart(int productId, int qty) {
    int index = _listCart!.data!
        .indexWhere((element) => element.product!.id == productId);
    CartModel _cart = _listCart!.data![index];
    _cart.qty = qty + 1;
    _cart.totalPrice = _cart.totalPrice! * _cart.qty!;
    notifyListeners();
    _listCart!.data![index] = _cart;
    notifyListeners();
    _saveDataToJson();
  }

  decreaseCart(int productId, int qty) {
    int index = _listCart!.data!
        .indexWhere((element) => element.product!.id == productId);
    CartModel _cart = _listCart!.data![index];
    if (qty == 1) {
      _listCart!.data!.removeAt(index);
      notifyListeners();
    } else {
      _cart.qty = qty - 1;
      _cart.totalPrice = _cart.totalPrice! * _cart.qty!;
      notifyListeners();
      _listCart!.data![index] = _cart;
    }
    _saveDataToJson();
  }
}
