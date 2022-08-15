// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shippingcart/helper/enum.dart';
import 'package:shippingcart/model/cart_model.dart';
import 'package:shippingcart/provider/cart_provider.dart';
import 'package:shippingcart/provider/product_provider.dart';
import 'package:shippingcart/utils/static.dart';
import 'package:shippingcart/utils/widgets/product_cart.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CartProvider>(context, listen: false).getDataFromLocal();
      Provider.of<CartProvider>(context, listen: false).setCart();
      // Provider.of<CartProvider>(context, listen: false).clearCart();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cardColors,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Consumer<ProductProvider>(builder: (context, notifier, child) {
            if (notifier.state == NotifierState.laoding) {
              return const SizedBox();
            } else {
              if (notifier.listProduct == null || notifier.listProduct == []) {
                return const SizedBox();
              } else {
                return Column(
                  children: [
                    ListView.builder(
                        padding: const EdgeInsets.only(bottom: 100),
                        itemCount: notifier.listProduct!.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ProductListView(notifier.listProduct![index]);
                        }),
                  ],
                );
              }
            }
          }),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: cart(),
    );
  }

  Widget cart() {
    return Consumer<CartProvider>(builder: (context, notifier, child) {
      int _count = 0;
      double? _total = 0.0;
      if (notifier.getCart != null) {
        final CartDataModel? cartDataModel = notifier.getCart;
        if (cartDataModel != null) {
          for (CartModel cart in cartDataModel.data!) {
            _count = _count + cart.qty!;
            _total = _total! + cart.totalPrice!;
          }
        }
      } else if (notifier.getCart == null || _count == 0) {
        return const SizedBox();
      }
      return _count == 0
          ? const SizedBox()
          : GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                // padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),

                child: Stack(children: [
                  Container(
                    padding: const EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                        color: seaGreen,
                        borderRadius: BorderRadius.circular(40)),
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: Row(children: [
                      const Icon(Icons.add_shopping_cart_rounded,
                          color: whiteColor),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text("Cart: $_count |",
                            style: mediumStyle.copyWith(color: whiteColor)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text("Total: \$$_total",
                            style: mediumStyle.copyWith(color: whiteColor)),
                      ),
                    ]),
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      height: 40,
                      width: 90,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 2, 69, 36),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: Center(
                        child: Text("Checkout",
                            style: mediumStyle.copyWith(color: whiteColor)),
                      ),
                    ),
                  )
                ]),
              ),
            );
    });
  }
}
