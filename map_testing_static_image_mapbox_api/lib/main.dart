import 'package:flutter/material.dart';
import 'map_box_api.dart';
import 'package:mapbox_search/mapbox_search.dart';

void main()=>runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MapBox API testing',
      home: Scaffold(body: MapBoxAPI(),),
    );
  }
}
