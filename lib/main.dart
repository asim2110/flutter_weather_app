import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/routs/app_pages.dart';
import 'package:weather_app/routs/app_routes.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      getPages: AppPages.pages,
    );
  }
}
