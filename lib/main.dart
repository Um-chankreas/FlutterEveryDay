import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shippingcart/provider/cart_provider.dart';
import 'package:shippingcart/provider/product_provider.dart';
import 'package:shippingcart/screen/splash_page.dart';
import 'package:shippingcart/utils/static.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            fontFamily: "Poppins",
            primaryColor: Colors.white,
            iconTheme: const IconThemeData(color: seaGreen),
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 0,
                iconTheme: IconThemeData(color: seaGreen))),
        home: const SplashPage(),
      ),
    );
  }
}
