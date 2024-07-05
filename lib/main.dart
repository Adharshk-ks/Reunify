import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Add this import for Firebase
import 'package:reunifyfiire/chat.dart';
import 'package:reunifyfiire/firebase_options.dart';
import 'package:reunifyfiire/login_page.dart';
import 'package:reunifyfiire/search.dart';
import 'package:reunifyfiire/settings.dart';
import 'package:reunifyfiire/newpostpage.dart';
import 'package:reunifyfiire/contact.dart';
import 'homepage.dart';
import 'profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    print("Firebase initialized successfully.");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Reunify",
      initialRoute: '/login', 
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/chat': (context) => const ChatPage(),
        '/settings': (context) => const SettingsPage(),
        '/newPost': (context) => const NewPostPage(),
        '/contact': (context) => const ContactPage(),
        '/search': (context) => const SearchPage(),
        
      },
      // home: LoginPage(),
    );
  }
}
