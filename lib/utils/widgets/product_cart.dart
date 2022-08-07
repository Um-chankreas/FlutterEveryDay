import 'package:flutter/material.dart';
import 'package:shippingcart/model/product_model.dart';
import 'package:shippingcart/utils/static.dart';
import 'package:shippingcart/utils/widgets/cache_image.dart';

class ProductListView extends StatefulWidget {
  final ProductModel listProduct;
  const ProductListView(this.listProduct, {Key? key}) : super(key: key);

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
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

  @override
  Widget build(BuildContext context) {
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
      ),
    );
  }
}
