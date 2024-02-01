import 'package:flutter/material.dart';
import 'package:untitled2/screens/home_screen.dart';
import 'package:sliver_tools/sliver_tools.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.amber,
      ),
      home: HomeScreen(),
    );
  }
}

