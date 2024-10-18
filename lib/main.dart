import 'package:flutter/material.dart';
import 'package:main_project/first_page.dart';

void main() {
  runApp(const MyApp());
}
var ip="192.168.29.92";
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,

        title: 'Flutter Demo',
      theme: ThemeData(


        primarySwatch: Colors.blue,
      ),
      home:FirstPage()
    );
  }
}
