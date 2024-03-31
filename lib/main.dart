import 'package:flutter/material.dart';
import 'package:reunify/login_page.dart';
import 'package:reunify/found_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Reunify",
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/found': (context) => FoundPage(),
      },
    );
  }
}
