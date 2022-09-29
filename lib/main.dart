import 'package:amazex/constants/global_variables.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: GlobalVariable.backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: GlobalVariable.backgroundColor,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
        ),

      ),
      home: const Text( 'Flutter Demo Home Page'),
    );
  }
}

