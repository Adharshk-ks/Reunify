import 'package:flutter/material.dart';
import 'package:reunify/profile_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool signUp = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            signUp ? 'assets/ch2.jpg' : 'assets/Android Large - 8.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            opacity: const AlwaysStoppedAnimation(.75),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            height: 60,
            width: double.infinity,
            child: Text(
              "Reunify",
              style: TextStyle(
                color: signUp ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
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
                      signUp ? "Sign Up" : "Log In",
                      style: const TextStyle(fontSize: 26),
                    ),
                  ),
                ),
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      signUp
                          ? Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              child: const TextField(
                                decoration: InputDecoration(
                                  hintText: "First Name",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      signUp
                          ? Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              child: const TextField(
                                decoration: InputDecoration(
                                  hintText: "Last Name",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      signUp
                          ? Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              child: const TextField(
                                decoration: InputDecoration(
                                  hintText: "Username",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ),
                      signUp
                          ? Container()
                          : const SizedBox(
                              height: 20,
                            ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: TextField(
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
                      signUp
                          ? Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              child: const TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "Confirm Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.only(top: 19, bottom: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/home');
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
                                        Color.fromARGB(255, 25, 26, 26),
                                        Color.fromARGB(255, 94, 98, 117),
                                      ],
                              ),
                            ),
                            child: Center(
                                child: Text(
                              signUp ? "SignUp" : "Login",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 251, 252, 251)),
                            )),
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
                                      ? Color.fromARGB(255, 52, 122, 236)
                                      : Color.fromARGB(255, 41, 93, 235),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ]),
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
