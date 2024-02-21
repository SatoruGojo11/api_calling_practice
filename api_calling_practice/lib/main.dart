import 'package:api_calling_practice/MyRetoolApi.dart';
import 'package:flutter/material.dart';

import 'Ecommerce_products.dart';
import 'HomePage.dart';

void main() {
  runApp(
    MaterialApp(
      highContrastDarkTheme: ThemeData(brightness: Brightness.dark),
      theme: ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      home: E_commerce_products(),
    ),
  );
}

text(name, color, size) {
  return Text(
    name,
    style: TextStyle(
      fontSize: size,
      color: color,
    ),
  );
}

field(color, h1, w1) {
  return Container(
    color: color,
    height: h1,
    width: w1,
  );
}

