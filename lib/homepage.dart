import 'package:flutter/material.dart';
import 'package:reunify/widget/bottom_navigation.dart';
import 'info.dart'; // Import the info.dart file where InfoPage is defined

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget _buildProductCard(BuildContext context, int index) {
    // Example product details (replace with actual data)
    String productName = 'House Key'; // Replace with actual product name
    String location = 'Kochi'; // Replace with actual location
    String contact = '9934567890'; // Replace with actual contact information

    return GestureDetector(
      onTap: () {
        // Navigate to InfoPage on tap
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InfoPage(
              productName: productName,
              location: location,
              contact: contact,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage('assets/wooden-keychain-white.jpg'), // Replace with your image asset path
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 26),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 28),
                    Text('Location: $location'),
                    Text('Contact: $contact'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reunify'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Add search functionality here
            },
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 34, 20, 41),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(bottom: 90, top: 50, left: 10),
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
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat, color: Color.fromARGB(255, 254, 254, 254)),
              title: const Text('Chat', style: TextStyle(color: Color.fromARGB(255, 254, 254, 254))),
              onTap: () {
                Navigator.pushNamed(context, '/contact');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Color.fromARGB(255, 251, 250, 250)),
              title: const Text('Settings', style: TextStyle(color: Color.fromARGB(255, 255, 254, 254))),
              onTap: () {
                // Add settings navigation functionality here
              },
            ),


            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Color.fromARGB(255, 254, 254, 254)),
              title: const Text('Logout', style: TextStyle(color: Color.fromARGB(255, 254, 254, 254))),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return _buildProductCard(context, index);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/newPost');
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: AppBottomNavigation(ci: 0),
    );
  }
}
