import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pass_app_meteo/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Meteo",
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
