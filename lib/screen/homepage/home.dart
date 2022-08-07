import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shippingcart/helper/enum.dart';
import 'package:shippingcart/model/product_model.dart';
import 'package:shippingcart/provider/product_provider.dart';
import 'package:shippingcart/utils/static.dart';
import 'package:shippingcart/utils/widgets/cache_image.dart';
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
      // Provider.of<ProductProvider>(context, listen: false).getProducts();
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
    );
  }
}
