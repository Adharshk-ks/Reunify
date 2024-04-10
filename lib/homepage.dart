import 'package:flutter/material.dart';
import 'package:reunify/widget/bottom_navigation.dart';
import 'package:gap/gap.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reunify'),
        actions: [
          // Corrected from 'action' to 'actions'
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Add search functionality here
            },
          ),
          // Add more actions as needed
        ],
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 34, 20, 41),
        // Add hamburger icon functionality here
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
           
            Padding(
              padding: const EdgeInsets.only(bottom: 90, top: 50, left: 10),
              child: Text(
                  'Reunify',
                  style: TextStyle(
                    color: Color(0xFFF3F2F2),
                    fontSize: 24,
                  ),
                ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Color.fromRGBO(251, 251, 251, 1)),
              title: const Text('Home', style: TextStyle(color: Color.fromARGB(255, 255, 254, 254))), 
              onTap: () {
                // Add home navigation functionality here
              },
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Color.fromARGB(255, 250, 248, 248)),
              title: const Text('Profile', style: TextStyle(color: Color.fromARGB(255, 255, 254, 254))),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
                // Add profile navigation functionality here
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat, color: Color.fromARGB(255, 254, 254, 254)),
              title: const Text('Chat', style: TextStyle(color: Color.fromARGB(255, 254, 254, 254))),
              onTap: () {
                Navigator.pushNamed(context, '/chat');
                // Add chat navigation functionality here
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Color.fromARGB(255, 251, 250, 250)),
              title: const Text('Settings', style: TextStyle(color: Color.fromARGB(255, 255, 254, 254))),
              onTap: () {
                // Add settings navigation functionality here
              },
            ),
            const Gap(325),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Color.fromARGB(255, 254, 254, 254)),
              title: const Text('Logout', style: TextStyle(color: Color.fromARGB(255, 254, 254, 254))),
              onTap: () {
                Navigator.pushNamed(context, '/login');
                // Add profile navigation functionality here
              },
            ),
          ],
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/Android Large - 8.jpg', // Replace with your image asset path
            fit: BoxFit.cover,
          ),
          // Other widgets can be added on top of the background image
          const Center(
            child: Text(
              'Welcome to Reunify',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNavigation(ci: 0,)
    );
  }
}
