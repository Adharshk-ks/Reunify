import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  final String productName;
  final String location;
  final String contact;
  final String imageUrl;

  const InfoPage({
    required this.productName,
    required this.location,
    required this.contact,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productName), // Use productName as the title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Location: $location',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                'Contact: $contact',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              // You can add more details as needed
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add chat functionality here
        },
        child: Icon(Icons.chat),
      ),
    );
  }
}
