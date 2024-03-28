import 'package:core_flutter_11am/screens/cart_page.dart';
import 'package:core_flutter_11am/screens/home_page.dart';
import 'package:core_flutter_11am/screens/product_detail_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
        'detail_page': (context) => const DetailPage(),
        'cart_page': (context) => const CartPage(),
      },
    ),
  );
}
