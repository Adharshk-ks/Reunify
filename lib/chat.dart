import 'package:flutter/material.dart';
import 'package:reunify/widget/bottom_navigation.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Message> _messages = [];
   // List of messages
 String? iptext;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('Chat'),
        // ),
        body: Stack(
          children: [
            // Background image
            Image.asset(
              'assets/chatbg.png', // Replace with your image asset path
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            // Chat messages
            ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/user_avatar.png'), // Replace with user's avatar
                  ),
                  title: Text(_messages[index].sender),
                  subtitle: Text(_messages[index].text),
                );
              },
            ),
            Container(
              height: 80,
              width: double.infinity,
              color: Colors.black.withOpacity(0.5),
              child: Column(
                children: [
                  SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 24,),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        'Chat',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ),
            // Input field for sending messages
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                // color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: TextField(
                          onChanged: (value) =>setState(() {
                            iptext=value;
                          }) ,
                          decoration: InputDecoration(
                            
                            hintText: 'Type your message...',
                            border: OutlineInputBorder(),
                          ),
                          onSubmitted: (text) {
                            _sendMessage(text);
                          },
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        // Send message functionality
                            _sendMessage( iptext.toString());

                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: AppBottomNavigation(ci: 2),
      ),
    );
  }

  void _sendMessage(String text) {
    setState(() {
      _messages.add(Message(sender: 'You', text: text));
      // Add logic for sending messages to other users
    });
  }
}

class Message {
  final String sender;
  final String text;

  Message({required this.sender, required this.text});
}
