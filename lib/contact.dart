import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat.dart'; 
import 'package:reunifyfiire/widget/bottom_navigation.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('messages')
            .where('sender', isEqualTo: user!.email)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var messageDocs = snapshot.data!.docs;
          Set<String> usersSet = Set<String>();

          // Collect unique users based on sender and receiver
          messageDocs.forEach((doc) {
            usersSet.add(doc['receiver']);
          });

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('messages')
                .where('receiver', isEqualTo: user.email)
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              var receivedMessageDocs = snapshot.data!.docs;
              receivedMessageDocs.forEach((doc) {
                usersSet.add(doc['sender']);
              });

              // Convert set to list for ListView builder
              List<String> usersList = usersSet.toList();

              return ListView.builder(
                itemCount: usersList.length,
                itemBuilder: (context, index) {
                  var otherUserEmail = usersList[index];

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/user_avatar.png'), // Replace with actual avatars
                    ),
                    title: Text(otherUserEmail),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(userEmail: otherUserEmail),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: AppBottomNavigation(ci: 2),
    );
  }
}
