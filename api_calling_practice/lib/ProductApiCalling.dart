import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shimmer/shimmer.dart';

import 'main.dart';

class ProductApiCall extends StatefulWidget {
  const ProductApiCall({super.key});

  @override
  State<ProductApiCall> createState() => _ProductApiCallState();
}

class _ProductApiCallState extends State<ProductApiCall> {
  ProductServices pdservice = ProductServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Api '),
      ),
      body: Center(
        child: FutureBuilder(
          future: ProductServices.getData(),
          builder: (context, snapShot) {
            print('Main Screen');
            if (snapShot.hasData) {
              List dataList = snapShot.data! as List;
              return ListView.separated(
                itemCount: dataList.length,
                separatorBuilder: (context, index) => Divider(thickness: 3),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    '${dataList[index].image.toString()}'))),
                      ),
                    ),
                    title: Text('${dataList[index].title}'),
                    subtitle: Text('${dataList[index].description.toString()}'),
                  );
                },
              );
            } else {
              return Shimmer.fromColors(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Container(
                        child: Row(
                          children: [
                            Center(child: Text('$index',style: TextStyle(fontSize: 30),),),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                field(Colors.grey, 10.0, 210.0),
                                SizedBox(height: 10),
                                field(Colors.grey, 10.0, 310.0),
                                SizedBox(height: 10),
                                field(Colors.grey, 10.0, 310.0),
                                SizedBox(height: 10),
                                field(Colors.grey, 10.0, 310.0),
                                SizedBox(height: 10),
                                field(Colors.grey, 10.0, 310.0),
                                SizedBox(height: 10),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(thickness: 3),
                    itemCount: 10,
                  ),
                ),
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.white,
              );
            }
          },
        ),
      ),
    );
  }
}

class ProductServices {
  static Future<List<ProductModel>> getData() async {
    var products = await get(Uri.https('fakestoreapi.com', 'products'));
    print('Product Service');

    if (products.statusCode == 200) {
      print('S1');
      List<dynamic> body = jsonDecode(products.body);
      print('S2');
      List<ProductModel> dataList = body.map((e) {
        var data = ProductModel.fromJson(e);
        return data;
      }).toList();
      //List<ProductModel> dataList = body.map((e) => ProductModel.fromJson(e) ).toList();
      print('S3');
      return dataList;
    } else {
      throw "Can't get Data";
    }
  }
}

class ProductModel {
  final int id, ratingcount;
  final String title, description, category, image;
  final double price, rate;

  ProductModel({
    required this.id,
    required this.ratingcount,
    required this.title,
    required this.description,
    required this.category,
    required this.image,
    required this.price,
    required this.rate,
  });

  factory ProductModel.fromJson(Map jsonData) {
    Map ratings = jsonData['rating'];
    var data = ProductModel(
      id: jsonData['id'] ?? 0,
      ratingcount: ratings['count'] ?? 0,
      title: jsonData['title'] ?? 'No data',
      description: jsonData['description'] ?? 'No data',
      category: jsonData['category'] ?? 'No data',
      image: jsonData['image'] ?? 'No data',
      price: jsonData['price'].toDouble() ?? 0.0,
      rate: ratings['rate'].toDouble() ?? 0.0,
    );
    return data;
  }
}

/*
List A = [
  {
    "id": 1,
    "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
    "price": 109.95,
    "description":
        "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
    "category": "men's clothing",
    "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
    "rating": {"rate": 3.9, "count": 120}
  },
];
*/
