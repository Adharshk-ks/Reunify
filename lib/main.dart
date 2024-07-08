import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reunifyfiire/chat.dart';
import 'package:reunifyfiire/firebase_options.dart';
import 'package:reunifyfiire/login_page.dart';
import 'package:reunifyfiire/search.dart';
import 'package:reunifyfiire/settings.dart';
import 'package:reunifyfiire/newpostpage.dart';
import 'package:reunifyfiire/contact.dart';
import 'homepage.dart';
import 'profile_page.dart';
import 'info.dart'; // Assuming info.dart is the file containing InfoPage

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
      initialRoute: FirebaseAuth.instance.currentUser == null ? '/login' : '/home',
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/chat': (context) => const ChatPage(userEmail: ''), // Default userId for route
        '/settings': (context) => const SettingsPage(),
        '/newPost': (context) => const NewPostPage(),
        '/contact': (context) => const ContactPage(),
        '/search': (context) => const SearchPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/info') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => InfoPage(
              productName: args['productName'],
              location: args['location'],
              contact: args['contact'],
              imageUrl: args['imageUrl'],
              userEmail: args['userEmail'], // Pass userEmail from arguments
              description: args['description'], // Pass description from arguments
              time: args['time'], // Pass time from arguments
              isListing: args['isListing'], // Pass isListing from arguments
            ),
          );
        }
        return null;
      },
    );
  }
}
