import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class RapidApiCountryCity extends StatefulWidget {
  const RapidApiCountryCity({super.key});

  @override
  State<RapidApiCountryCity> createState() => _RapidApiCountryCityState();
}

class _RapidApiCountryCityState extends State<RapidApiCountryCity> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApiData();
  }
  Future getApiData() async {
    print('2');

    var url = await Uri.parse(
        'https://countries-cities.p.rapidapi.com/location/country/list');
    var response = await http.get(url, headers: {
      'X-RapidAPI-Key': '9b18305f95msh7dd5c2b89ec3ecap1cbeb8jsnaa4358a96ceb',
      'X-RapidAPI-Host': 'countries-cities.p.rapidapi.com'
    });
    print(response);

    var country = await jsonDecode(response.body);
    print(country);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text(
          'Countries City',
          Colors.white,
          25.0,
        ),
      ),
      body: Center(
        child: text(
          'Rapid Api Countries City',
          Colors.black,
          25.0,
        ),
      ),
    );
  }
}
