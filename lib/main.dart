import 'package:flutter/material.dart';
import 'package:reunify/chat.dart';
import 'package:reunify/login_page.dart';
import 'package:reunify/settings.dart';
import 'package:reunify/newpostpage.dart';
import 'package:reunify/contact.dart';

import 'homepage.dart';
import 'profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Reunify",
      initialRoute: '/contact',
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/chat': (context) => const ChatPage(),
        '/settings': (context) => const SettingsPage(),
        '/newPost': (context) => const NewPostPage(),
        '/contact': (context) => const ContactPage(),

      },
      // home: LoginPage(),
    );
  }
}
