import 'package:flutter/material.dart';
import 'chat.dart'; // Ensure this import is correct
import 'package:reunifyfiire/widget/bottom_navigation.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.5),
        title: Text(
          'Contacts',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      body: ListView(
        children: List.generate(10, (index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/user_avatar.png'), // Replace with actual avatars
            ),
            title: Text('User ${index + 1}'),
            subtitle: Text('Hey there! I am using this app.'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatPage()),
              );
            },
          );
        }),
      ),
      bottomNavigationBar: AppBottomNavigation(ci: 2),
    );
  }
}
