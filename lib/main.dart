import 'package:flutter/material.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: "Poppins",
          primaryColor: Colors.white,
          iconTheme: IconThemeData(color: seaGreen),
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: seaGreen))),
      home: const SplashPage(),
    );
  }
}
