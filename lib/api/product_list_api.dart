import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shippingcart/model/product_model.dart';

class ProductApi {
  Future<ProductDataModel?> getProduct() async {
    var response = await rootBundle.loadString("json/product.json");
    var data = await json.decode(response);
    return ProductDataModel.fromJson(data);
  }
}
