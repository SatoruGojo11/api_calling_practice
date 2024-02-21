import 'package:flutter/material.dart';

import 'MyRetoolApi.dart';
import 'ProductApiCalling.dart';
import 'RapidApiCountriesCity.dart';
import 'UnsplashPhotoApi.dart';
import 'UserApiCalling.dart';
import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List Titles = [
    "User's Api At StoreRestApi.com",
    "Product's Api At FakeStoreapi.com",
    "Photo's Api At Unsplash.com",
    "Countries City Api At RapidApi.com",
    "User Details api at Retool.com Api Generator",
  ];

  List Subtitles = [
    "Api Link :- https://api.storerestapi.com/users",
    "Api Link :- https://fakestoreapi.com/products",
    "Api Link :- https://api.unsplash.com/photos/?client_id=Up2lW2mW8x9Ixivl4PQiQiwjWjsAr2210EnDGOZ1Yvg",
    "Api Link :- https://countries-cities.p.rapidapi.com/location/country/list",
    "Api Link :- https://retoolapi.dev/j8Dz1T/user_details",
  ];

  List ApiPages = [
    UsersApiCall(),
    ProductApiCall(),
    UnsplashApiCall(),
    RapidApiCountryCity(),
    MyRetoolApi(),
  ];

  bool s1 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            s1 ? Theme.of(context).brightness : Theme.of(context).brightness ;
          }, icon: Icon(Icons.dark_mode),),
        ],
        title: text('Api Calling', Colors.white, 25.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: Titles.length,
          separatorBuilder: (context, index) => Divider(thickness: 3),
          itemBuilder: (context, index) {
            return ListTile(
              title: text('${Titles[index]}', Colors.black, 20.0),
              leading: text("${index + 1}", Colors.black, 25.0),
              subtitle: text('${Subtitles[index]}', Colors.black, 18.0),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ApiPages[index],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
