import 'package:flutter/material.dart';

class AppBottomNavigation extends StatelessWidget {
  int ci;
   AppBottomNavigation({super.key , required this.ci});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: ci,
        onTap: (int index) {
          if (index == 0) Navigator.pushNamed(context, "/home");
          if (index == 1) Navigator.pushNamed(context, "/profile");
          if (index == 2) Navigator.pushNamed(context, "/chat");
          // if(index==3)Navigator.pushNamed(context, "/home");
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: const Color.fromARGB(255, 38, 39, 40),
        unselectedItemColor:
            const Color.fromARGB(255, 38, 39, 40).withOpacity(0.5),
        // Add navigation functionality here
      );
  }
}