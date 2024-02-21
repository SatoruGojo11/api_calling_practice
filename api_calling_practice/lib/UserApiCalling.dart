import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shimmer/shimmer.dart';
import 'main.dart';

class UsersApiCall extends StatefulWidget {
  const UsersApiCall({super.key});

  @override
  State<UsersApiCall> createState() => _UsersApiCallState();
}

class _UsersApiCallState extends State<UsersApiCall> {
  UserService mainservice = UserService();

  @override
  Widget build(BuildContext context) {
    MediaQueryData md = MediaQueryData();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(
                  () {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                          dismissDirection: DismissDirection.horizontal,
                          content: text(
                            'Page Refreshed',
                            Colors.white,
                            20),
                        ),
                      );
                  },
                );
              },
              icon: Icon(Icons.refresh))
        ],
        title: text('User Api Calling', Colors.white, 25.0),
      ),
      body: Center(
        child: FutureBuilder(
          future: mainservice.getdata(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<UserModel> DataList = snapshot.data!;
              print(DataList);
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(thickness: 3),
                itemCount: DataList.length,
                itemBuilder: (context, index) {
                  try {
                    return ListTile(
                      title: text(
                        '${DataList[index].role.toString()}',
                        Colors.black,
                        20.0),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text('Status :- ${mainservice.Status}',
                              Colors.black, 15.0),
                          text('Message :- ${mainservice.Message}',
                              Colors.black, 15.0),
                          text('name :- ${DataList[index].name.toString()}',
                              Colors.black, 15.0),
                          text('Email :- ${DataList[index].email.toString()}',
                              Colors.black, 15.0),
                          text(
                              'Number :- ${DataList[index].number.toString()}',
                              Colors.black,
                              15.0,),
                          text(
                              'Starting Date :- ${DataList[index].createdAt.toString()}',
                              Colors.black,
                              15.0,),
                          text(
                              'Updating Date :- ${DataList[index].updatedAt.toString()}',
                              Colors.black,
                              15.0,),
                          text(
                              'Last Login At :- ${DataList[index].lastLoginAt.toString()}',
                              Colors.black,
                              15.0,),
                        ],
                      ),
                      leading: Container(
                        child: text('${index + 1}', Colors.black, 25),
                      ),
                    );
                  } catch (e) {
                    return CircularProgressIndicator(
                      color: Colors.deepOrange,
                    );
                  }
                },
              );
            } else if (snapshot.hasError) {
              return CircularProgressIndicator();
            }
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
          },
        ),
      ),
    );
  }
}

class UserService {
  var Status, Message;

  Future<List<UserModel>> getdata() async {
    var user = await get(Uri.https('api.storerestapi.com', 'users'));

    if (user.statusCode == 200) {
      Map user1 = await jsonDecode(user.body);
      Status = user1['status'];
      Message = user1['message'];

      List<dynamic> bodydata = user1['data'];

      List<UserModel> dataList =
          await bodydata.map((e) => UserModel.fromJson(e)).toList();
      return dataList;
    } else {
      throw "Can't Load data";
    }
  }
}


class UserModel {
  int number;
  String role, id, name, email, pass, createdAt, updatedAt, lastLoginAt;

  UserModel({
    required this.number,
    required this.role,
    required this.id,
    required this.name,
    required this.email,
    required this.pass,
    required this.createdAt,
    required this.updatedAt,
    required this.lastLoginAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsondata) {
    var usersdata = UserModel(
      number: int.parse('${jsondata['number'] ?? 0}'),
      role: jsondata['role'] ?? 'No data',
      id: jsondata['_id'] ?? 'No data',
      name: jsondata['name'] ?? 'No data',
      email: jsondata['email'] ?? 'No data',
      pass: jsondata['password'] ?? 'No data',
      createdAt: jsondata['createdAt'] ?? 'No data',
      updatedAt: jsondata['updatedAt'] ?? 'No data',
      lastLoginAt: jsondata['lastLoginAt'] ?? 'No data',
    );
    return usersdata;
  }
}
