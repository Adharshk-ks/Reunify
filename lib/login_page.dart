import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reunify/found_page.dart'; // Import the FoundPage

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Reunify",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.black,
        ),
        body: Stack(
          children: [
            Image.asset(
              'assets/login_bg1.png',
              fit: BoxFit.fitHeight,
              height: double.infinity,
              opacity: const AlwaysStoppedAnimation(.75),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: Center(
                      child: Text(
                        "Log In",
                        style: GoogleFonts.teko(fontSize: 40),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 350,
                    width: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white,
                          ),
                          child: const TextField(
                            decoration: InputDecoration(
                              hintText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white,
                          ),
                          child: const TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to FoundPage when the button is pressed
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FoundPage(),
                              ),
                            );
                          },
                          child: const Text("Login"),
                        ),
                        RichText(
                          text: const TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(fontSize: 18),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Sign in',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to FoundPage when the button is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FoundPage(),
                        ),
                      );
                    },
                    child: const Text("Go to Found Page"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
