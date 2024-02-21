import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class E_commerce_products extends StatefulWidget {
  const E_commerce_products({super.key});

  @override
  State<E_commerce_products> createState() => _E_commerce_productsState();
}

class _E_commerce_productsState extends State<E_commerce_products> {
  var apidata;

  Future getProducts() async {
    var rawdata = await http.get(
      Uri.parse('https://fir-a-to-z-default-rtdb.firebaseio.com/Products.json'),
    );

    if (rawdata.statusCode == 200) {
      var listdata = await jsonDecode(rawdata.body);
      setState(() {
        apidata = listdata;
      });
      return apidata;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Divu Api [E-Commerce Products]"),
      ),
      body: apidata == null
          ? CircularProgressIndicator()
          : SingleChildScrollView(
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                separatorBuilder: (context, index) => Divider(
                  thickness: 3,
                ),
                itemCount: apidata.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(backgroundImage: NetworkImage(apidata[index]['image_url'].toString())),
                    title: Text(apidata[index]['name'].toString()),
                    subtitle: Text(apidata[index]['price'].toString()),
                  );
                },
              ),
            ),
    );
  }
}

/*class ProductsModel {
  String expiry_date, image_url, name;
  int price;

  ProductsModel(
      {required this.expiry_date,
      required this.image_url,
      required this.name,
      required this.price});

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      expiry_date: json['expiry_date'] ?? '',
      image_url: json['image_url'] ?? '',
      name: json['name'] ?? '',
      price: json['price'] ?? 0,
    );
  }
}*/
