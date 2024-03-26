import 'package:flutter/material.dart';
import 'package:reunify/widget/bottom_navigation.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

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
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  
                  },
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () {
                      Navigator.pop(context);
                      // Implement back button functionality
                    },
                  ),
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
                    // Implement edit button functionality
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
                _buildInputField(label: 'Name', hintText: 'Enter your name'),
                const SizedBox(height: 20),
                _buildInputField(label: 'Email', hintText: 'Enter your email'),
                const SizedBox(height: 20),
                _buildInputField(
                    label: 'Country', hintText: 'Enter your country'),
                const SizedBox(height: 20),
                _buildInputField(
                    label: 'Date of Birth',
                    hintText: 'Enter your date of birth'),
                const SizedBox(height: 30),
                Container(
                  height: 50,
                  width: 200,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 8, 8, 16),
                      Color.fromARGB(255, 87, 93, 122),
                    ]),
                  ),
                  child: const Center(
                      child: Text(
                    'Save Changes',
                    style: TextStyle(color: Color.fromARGB(255, 251, 252, 251)),
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNavigation(ci: 1),
    );
  }

  Widget _buildInputField({required String label, required String hintText}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
