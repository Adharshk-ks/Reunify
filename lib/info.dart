import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat.dart';

class InfoPage extends StatelessWidget {
  final String productName;
  final String location;
  final String contact;
  final String imageUrl;
  final String userEmail; // Added field for user email
  final String description; // Added field for description
  final bool isListing; // Added field for listing status (FOUND or LOST)
  final String time; // Added field for time

  const InfoPage({
    required this.productName,
    required this.location,
    required this.contact,
    required this.imageUrl,
    required this.userEmail,
    required this.description,
    required this.isListing,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor = isListing ? Colors.green : Colors.red;
    String statusText = isListing ? 'FOUND' : 'LOST';

    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
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
              SizedBox(height: 12),
              Text(
                'Description: $description',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                'Status: ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                statusText,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Time: $time',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              // You can add more details as needed
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(userEmail: userEmail),
            ),
          );
        },
        child: Icon(Icons.chat),
      ),
    );
  }
}
