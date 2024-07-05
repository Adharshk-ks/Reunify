import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Add this import for Firebase Auth
import 'package:cloud_firestore/cloud_firestore.dart'; // Add this import for Firestore
import 'package:reunifyfiire/profile_page.dart'; 

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool signUp = false;
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Firestore instance
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.pushNamed(context, '/home');
    } catch (e) {
      print('Error: $e');
      // Handle error (e.g., show a Snackbar or Dialog)
    }
  }

  Future<void> _signUp() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      // Handle password mismatch (e.g., show a Snackbar or Dialog)
      return;
    }
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Save additional user information like firstName and username here
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'firstName': _firstNameController.text,
        'username': _usernameController.text,
        'email': _emailController.text,
      });

      Navigator.pushNamed(context, '/home');
    } catch (e) {
      print('Error: $e');
      // Handle error (e.g., show a Snackbar or Dialog)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/Login.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            opacity: const AlwaysStoppedAnimation(.75),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 5),
            child: Container(
              margin: const EdgeInsets.all(10),
              height: 60,
              width: double.infinity,
              child: Text(
                "Reunify",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                SizedBox(
                  height: signUp ? 200 : 250,
                  child: Center(
                    child: Text(
                      signUp ? "Sign Up" : "Login",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (signUp)
                        Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: _firstNameController,
                            decoration: const InputDecoration(
                              hintText: "First Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (signUp)
                        Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                              hintText: "Username",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (!signUp)
                        const SizedBox(
                          height: 20,
                        ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: signUp ? "Create Password" : "Password",
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (signUp)
                        Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: _confirmPasswordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: "Confirm Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(top: 19, bottom: 20),
                        child: InkWell(
                          onTap: () {
                            if (signUp) {
                              _signUp();
                            } else {
                              _login();
                            }
                          },
                          child: Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromARGB(255, 67, 59, 59),
                                    blurRadius: 4,
                                    offset: Offset(4, 4))
                              ],
                              borderRadius: const BorderRadius.all(
                                Radius.circular(30),
                              ),
                              gradient: LinearGradient(
                                colors: signUp
                                    ? [
                                        Color.fromARGB(255, 248, 137, 33),
                                        Color.fromARGB(255, 236, 48, 48),
                                      ]
                                    : [
                                        Color.fromARGB(255, 12, 12, 12),
                                        Color.fromARGB(255, 10, 10, 10),
                                      ],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                signUp ? "Sign Up" : "Login",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 251, 252, 251)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            signUp
                                ? "Already have an account?"
                                : "Don't have an account? ",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                signUp = !signUp;
                              });
                            },
                            child: Text(
                              signUp ? " Login" : 'Sign up',
                              style: TextStyle(
                                color: signUp
                                    ? const Color.fromARGB(255, 52, 122, 236)
                                    : const Color.fromARGB(255, 41, 93, 235),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
