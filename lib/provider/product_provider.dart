import 'package:flutter/cupertino.dart';
import 'package:shippingcart/api/product_list_api.dart';
import 'package:shippingcart/helper/enum.dart';
import 'package:shippingcart/model/product_model.dart';

class ProductProvider with ChangeNotifier {
  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;
  void setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  List<ProductModel>? _listProduct;
  List<ProductModel>? get listProduct => _listProduct;
  Future getProducts() async {
    if (_listProduct == null) {
      setState(NotifierState.laoding);
    }
    await ProductApi().getProduct().then((value) {
      _listProduct = value!.data;
    });
    setState(NotifierState.loaded);
  }
}
