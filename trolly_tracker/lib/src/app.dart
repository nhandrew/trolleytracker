import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trolly_tracker/src/screens/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff144b88)
        )
      ),
      home: const Home(),
    );
  }
}