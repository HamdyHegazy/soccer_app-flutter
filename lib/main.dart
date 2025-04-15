import 'package:flutter/material.dart';
import 'package:premier_league_table/dio.dart';
import 'package:premier_league_table/home.dart';

void main() {
  DioHelper.init(url: "https://api.sportsdata.io");
  DioHelperr.init(url: "https://apiv2.allsportsapi.com");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF000000),
          appBarTheme: const AppBarTheme(
            color: Colors.white,
          )),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
