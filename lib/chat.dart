import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class ChatPage extends StatefulWidget {
  final String userEmail; // Pass the userEmail of the contact

  const ChatPage({Key? key, required this.userEmail}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Message> _messages = [];
  final TextEditingController _messageController = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;

  late Stream<List<Message>> _messageStream;

  @override
  void initState() {
    super.initState();
    _messageStream = _combineStreams();
  }

  Stream<List<Message>> _combineStreams() {
    String chatId = _getChatId();

    Stream<List<Message>> sentMessagesStream = FirebaseFirestore.instance
        .collection('messages')
        .where('sender', isEqualTo: user!.email)
        .where('receiver', isEqualTo: widget.userEmail)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return Message(
                sender: doc['sender'],
                receiver: doc['receiver'],
                text: doc['text'],
                timestamp: (doc['timestamp'] as Timestamp).toDate(),
              );
            }).toList());

    Stream<List<Message>> receivedMessagesStream = FirebaseFirestore.instance
        .collection('messages')
        .where('sender', isEqualTo: widget.userEmail)
        .where('receiver', isEqualTo: user!.email)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return Message(
                sender: doc['sender'],
                receiver: doc['receiver'],
                text: doc['text'],
                timestamp: (doc['timestamp'] as Timestamp).toDate(),
              );
            }).toList());

    return Rx.combineLatest2(
        sentMessagesStream, receivedMessagesStream, (sent, received) {
      List<Message> combinedMessages = [];
      combinedMessages.addAll(sent);
      combinedMessages.addAll(received);
      combinedMessages.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      return combinedMessages;
    });
  }

  String _getChatId() {
    return user!.uid.hashCode <= widget.userEmail.hashCode
        ? '${user!.uid}-${widget.userEmail}'
        : '${widget.userEmail}-${user!.uid}';
  }

  void _sendMessage(String text) {
    var message = Message(
      sender: user!.email!,
      receiver: widget.userEmail,
      text: text,
      timestamp: DateTime.now(),
    );

    FirebaseFirestore.instance.collection('messages').add({
      'chatId': _getChatId(),
      'sender': message.sender,
      'receiver': message.receiver,
      'text': message.text,
      'timestamp': Timestamp.fromDate(message.timestamp),
    });

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.5),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Chat',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: _messageStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                _messages.clear();
                _messages.addAll(snapshot.data!);

                return ListView.builder(
                  reverse: true,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    var message = _messages[index];
                    bool isSentMessage = message.sender == user!.email;

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('assets/user_avatar.png'),
                      ),
                      title: Text(isSentMessage ? 'You' : message.sender),
                      subtitle: Text(message.text),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Color.fromARGB(255, 250, 250, 252),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (text) {
                      if (text.isNotEmpty) {
                        _sendMessage(text);
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    var text = _messageController.text.trim();
                    if (text.isNotEmpty) {
                      _sendMessage(text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String sender;
  final String receiver;
  final String text;
  final DateTime timestamp;

  Message({
    required this.sender,
    required this.receiver,
    required this.text,
    required this.timestamp,
  });
}
