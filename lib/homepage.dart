import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reunifyfiire/widget/bottom_navigation.dart';
import 'info.dart'; // Import the info.dart file where InfoPage is defined

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget _buildProductCard(BuildContext context, DocumentSnapshot document) {
    // Extract product details from the Firestore document
    String productName = document['name'];
    String location = document['location'];
    String contact = document['contact'];
    String imageUrl = document['imageUrl'];

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
              imageUrl: imageUrl,
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
                    image: NetworkImage(imageUrl),
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
                    SizedBox(height: 8),
                    Text('Location: $location'),
                    Text('Contact: $contact'),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Wrap(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.delete),
                            title: Text('Delete'),
                            onTap: () {
                              FirebaseFirestore.instance
                                  .collection('posts')
                                  .doc(document.id)
                                  .delete()
                                  .then((_) {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Item deleted'),
                                  ),
                                );
                              });
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
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
              Navigator.pushNamed(context, '/search');
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
      body: Container(
        color: Color.fromARGB(255, 236, 215, 252), // Set your desired background color here
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('posts').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return _buildProductCard(context, snapshot.data!.docs[index]);
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/newPost');
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: AppBottomNavigation(ci: 0),
    );
  }
}
