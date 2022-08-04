import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shippingcart/helper/enum.dart';
import 'package:shippingcart/provider/product_provider.dart';
import 'package:shippingcart/utils/static.dart';
import 'package:shippingcart/utils/widgets/cache_image.dart';

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
                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    // changes position of shadow
                                  )
                                ]),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  width: 110,
                                  height: 110,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)),
                                    border: Border.all(
                                        color: Colors.transparent, width: 0),
                                  ),
                                  child: CacheImageWidget(
                                    borderRadius: BorderRadius.circular(10),
                                    url:
                                        "${notifier.listProduct![index].image}",
                                    aspectRatio: 1 * 1,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${notifier.listProduct![index].name}",
                                          maxLines: 2,
                                          style: normalStyle,
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          "\$${notifier.listProduct![index].price![0].price} | ${notifier.listProduct![index].price![0].name}",
                                          style: normalStyle.copyWith(
                                              color: redColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
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
