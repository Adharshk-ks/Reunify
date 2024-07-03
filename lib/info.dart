import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  final String productName;
  final String location;
  final String contact;

  // Constructor to receive data from the home page
  const InfoPage({
    Key? key,
    required this.productName,
    required this.location,
    required this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productName), // Use product name as the title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product: $productName',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text('Location: $location'),
            Text('Contact: $contact'),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
