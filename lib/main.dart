import 'package:barcode/homeScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.    gg
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safebite',
      routes: {
        "/principale": (context) => const HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: "/principale",
    );
  }
}
