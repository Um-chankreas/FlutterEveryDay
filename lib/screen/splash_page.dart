import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shippingcart/screen/bottom_navabar.dart';
import 'package:shippingcart/utils/static.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) =>
        Navigator.of(context).pushReplacement(
            CupertinoPageRoute(builder: (context) => const BottomNavaBar())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.zero,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add_shopping_cart_rounded,
                  color: seaGreen, size: 100),
              Text(
                "Shipping Cart",
                style: boldStyle.copyWith(color: seaGreen),
              ),
              const SizedBox(height: 16),
              const SpinKitCircle(
                color: seaGreen,
                size: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
