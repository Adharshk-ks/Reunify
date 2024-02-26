import 'package:flutter/material.dart';
import 'package:reunify/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: "Reunify",
      home: LoginPage(),
    );
  }
}