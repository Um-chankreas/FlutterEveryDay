import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shippingcart/model/cart_model.dart';
import 'package:shippingcart/model/product_model.dart';
import 'package:shippingcart/provider/cart_provider.dart';
import 'package:shippingcart/utils/static.dart';
import 'package:shippingcart/utils/widgets/cache_image.dart';

class ProductListView extends StatefulWidget {
  final ProductModel listProduct;
  const ProductListView(this.listProduct, {Key? key}) : super(key: key);

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  int count = 0;
  @override
  void initState() {
    Provider.of<CartProvider>(context, listen: false).getDataFromLocal();

    super.initState();
  }

  increseCart(int productId, int qty) {
    Provider.of<CartProvider>(context, listen: false)
        .increaseCart(productId, qty);
  }

  deCreseCart(int productId, int qty) {
    Provider.of<CartProvider>(context, listen: false)
        .decreaseCart(productId, qty);
    if (qty == 1) {
      setState(() {
        count = 0;
      });
    }
  }

  addTocart(ProductModel product) {
    Provider.of<CartProvider>(context, listen: false).addToCart(product);
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);

    getCount() {
      if (cartProvider.getCart != null) {
        final CartDataModel? cartDataModel = cartProvider.getCart;
        List<CartModel> items = cartDataModel!.data!
            .where((element) => element.product!.id == widget.listProduct.id)
            .toList();

        for (CartModel item in items) {
          setState(() {
            count = item.qty!;
          });
        }
      } else {
        count = 0;
      }
    }

    if (cartProvider.getCart != null) {
      final CartDataModel? cartDataModel = cartProvider.getCart;
      List<CartModel> items = cartDataModel!.data!
          .where((element) => element.product!.id == widget.listProduct.id)
          .toList();

      for (CartModel item in items) {
        setState(() {
          count = item.qty!;
        });
      }
    } else {
      count = 0;
    }
    return GestureDetector(
      onTap: () {
        _showBottomSheet(widget.listProduct);
      },
      child: Container(
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
        child: Stack(
          children: [
            count == 0
                ? const SizedBox()
                : Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 3, bottom: 3, right: 8, left: 8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade100),
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(50)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              deCreseCart(widget.listProduct.id!, count);
                              getCount();
                            },
                            child: Icon(
                              count == 1 ? Icons.delete : Icons.remove,
                              color: redColor,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            count.toString(),
                            style: normalStyle,
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              increseCart(widget.listProduct.id!, count);
                              getCount();
                            },
                            child: const Icon(
                              Icons.add,
                              color: seaGreen,
                            ),
                          )
                        ],
                      ),
                    )),
            count != 0
                ? const SizedBox()
                : Positioned(
                    bottom: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        addTocart(widget.listProduct);
                        getCount();
                      },
                      child: (Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade100),
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: const Icon(
                          Icons.add,
                          color: seaGreen,
                        ),
                      )),
                    ),
                  ),
            Row(
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
                    border: Border.all(color: Colors.transparent, width: 0),
                  ),
                  child: CacheImageWidget(
                    borderRadius: BorderRadius.circular(10),
                    url: "${widget.listProduct.image}",
                    aspectRatio: 1 * 1,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.listProduct.name}",
                          maxLines: 2,
                          style: normalStyle,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "\$${widget.listProduct.price![0].price} | ${widget.listProduct.price![0].name}",
                          style: normalStyle.copyWith(color: redColor),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _showBottomSheet(ProductModel productModel) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
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
                          border:
                              Border.all(color: Colors.transparent, width: 0),
                        ),
                        child: CacheImageWidget(
                          borderRadius: BorderRadius.circular(10),
                          url: "${productModel.image}",
                          aspectRatio: 1 * 1,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${productModel.name}",
                              style: mediumStyle,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "\$${productModel.price![0].price} | ${productModel.price![0].name}",
                              style: normalStyle.copyWith(color: redColor),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const Text(
                    "Description",
                    style: boldStyle,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${productModel.description}",
                    style: normalStyle,
                    textAlign: TextAlign.justify,
                  )
                ],
              ));
        });
  }
}
