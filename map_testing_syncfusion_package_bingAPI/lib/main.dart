import 'package:flutter/material.dart';
import 'map_testing1.dart';
import 'map_testing2.dart';
import 'map_testing3.dart';

void main() =>runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'open street map testing',
      home: Scaffold(body: MapTesting3(),),
    );
  }
}
