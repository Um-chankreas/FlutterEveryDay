import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shippingcart/provider/product_provider.dart';
import 'package:shippingcart/screen/cart/cart_order.dart';
import 'package:shippingcart/screen/favorite/product_favorite.dart';
import 'package:shippingcart/screen/history/order_history.dart';
import 'package:shippingcart/screen/homepage/home.dart';
import 'package:shippingcart/utils/static.dart';

class BottomNavaBar extends StatefulWidget {
// ignore: use_key_in_widget_constructors
  const BottomNavaBar();

  @override
  State<BottomNavaBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavaBar> {
  final List<Tab> myTabs = <Tab>[
    const Tab(text: "Product"),
    const Tab(text: "Cart"),
    const Tab(text: "Favorite"),
    const Tab(text: "History"),
  ];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false).getProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Shipping Cart",
              style: boldStyle.copyWith(color: seaGreen),
            ),
            actions: const [
              Icon(
                Icons.add_shopping_cart_rounded,
                color: seaGreen,
              )
            ],
            bottom: TabBar(
              tabs: myTabs,
            ),
          ),
          body: const TabBarView(children: [
            HomePage(),
            CartOrder(),
            MyFavorite(),
            HistoryOrder(),
          ])),
    );
  }
}
