import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class MyRetoolApi extends StatefulWidget {
  const MyRetoolApi({super.key});

  @override
  State<MyRetoolApi> createState() => _MyRetoolApiState();
}

class _MyRetoolApiState extends State<MyRetoolApi> {
  // var alldata;

  // Future getData() async {
  //   var response = await http.get(
  //     Uri.parse('https://retoolapi.dev/j8Dz1T/user_details'),
  //   );
  //   var data = jsonDecode(response.body);
  //   // print(data[0]['id']);
  //
  //   setState(() {
  //     alldata = data;
  //   });
  // }

  RetoolService sv = RetoolService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            text('Retool Api made by me', Colors.white, 25.0),
      ),
      body: FutureBuilder(
        future: sv.getdata(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List d1 = snapshot.data!;
            return ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: text(d1[index], Colors.black, 20.0),
                    // leading: text(
                    //     '${d1[index]['id']}', Colors.black, 20.0, FontWeight.bold)
                  );
                },
                separatorBuilder: (context, index) => Divider(thickness: 3),
                itemCount: d1.length);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class RetoolService {
  Future<List> getdata() async {
    var response =
        await http.get(Uri.parse('https://retoolapi.dev/j8Dz1T/user_details'));

    if (response.statusCode == 200) {
      List<dynamic> urldata = await jsonDecode(response.body);
      print(urldata);
      List dataList = await urldata.map((e) {
        var temp = RetoolModel.fromJson(e);
        return temp;
      }).toList();
      print(dataList);
      return dataList;
    } else {
      throw "Can't Load data";
    }
  }
}

class RetoolModel {
  int id;
  String name, address, companyname;

  RetoolModel({
    required this.id,
    required this.name,
    required this.address,
    required this.companyname,
  });

  factory RetoolModel.fromJson(Map<String, dynamic> jsondata) {
    var abc = RetoolModel(
      id: jsondata['id'] ?? 0,
      name: jsondata['Name'] ?? 'No data',
      address: jsondata['Address'] ?? 'No data',
      companyname: jsondata['Company Name'] ?? 'No data',
    );
    return abc;
  }
}

/*body: alldata == null
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
              separatorBuilder: (context, index) => Divider(thickness: 3),
              itemCount: alldata.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: text('${alldata[index]['id']}', Colors.black, 30.0,
                      FontWeight.bold),
                  title: text('${alldata[index]['Name']}', Colors.black, 25.0,
                      FontWeight.bold),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text('${alldata[index]['Address']}', Colors.black, 20.0,
                          FontWeight.normal),
                      text('${alldata[index]['Company Name']}', Colors.black, 20.0, FontWeight.normal),
                    ],
                  ),
                );
              },
            ),*/
