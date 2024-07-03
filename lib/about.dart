import 'package:flutter/material.dart';
import 'package:reunify/about.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Center(
        child: Text(
          'Welcome to our About Us page!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}