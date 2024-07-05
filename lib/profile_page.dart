import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reunifyfiire/widget/bottom_navigation.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isEditing = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  late String _userId;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _userId = user.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(_userId).get();
      setState(() {
        _nameController.text = userDoc['firstName'];
        _emailController.text = userDoc['email'];
        _usernameController.text = userDoc['username'];
      });
    }
  }

  Future<void> _saveChanges() async {
    if (_userId.isNotEmpty) {
      await FirebaseFirestore.instance.collection('users').doc(_userId).update({
        'firstName': _nameController.text,
        'email': _emailController.text,
        'username': _usernameController.text,
      });
      setState(() {
        _isEditing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Text(
                  'Profile Page',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      _isEditing = true;
                    });
                  },
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Icon(
                    Icons.person,
                    size: 100,
                  ),
                ),
                const SizedBox(height: 30),
                _buildInputField(
                  controller: _nameController,
                  label: 'Name',
                  hintText: 'Enter your name',
                  enabled: _isEditing,
                ),
                const SizedBox(height: 20),
                _buildInputField(
                  controller: _emailController,
                  label: 'Email',
                  hintText: 'Enter your email',
                  enabled: _isEditing,
                ),
                const SizedBox(height: 20),
                _buildInputField(
                  controller: _usernameController,
                  label: 'Username',
                  hintText: 'Enter your username',
                  enabled: _isEditing,
                ),
                const SizedBox(height: 30),
                _isEditing
                    ? ElevatedButton(
                        onPressed: _saveChanges,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Save Changes',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNavigation(ci: 1),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required bool enabled,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
