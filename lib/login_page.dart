import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool signUp = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              signUp ? 'assets/pg_2.jpg' : 'assets/login_bg1.png',
              fit: BoxFit.fitHeight,
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
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.white,
                                ),
                                child: const TextField(
                                  decoration: InputDecoration(
                                    hintText: "First Name",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(40),
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
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.white,
                                ),
                                child: const TextField(
                                  decoration: InputDecoration(
                                    hintText: "Last Name",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(40),
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
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.white,
                                ),
                                child: const TextField(
                                  decoration: InputDecoration(
                                    hintText: "Username",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(40),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                        Container(
                          margin: const EdgeInsets.all(10),
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
                        signUp
                            ? Container()
                            : const SizedBox(
                                height: 20,
                              ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white,
                          ),
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: signUp ? "Create Password" : "Password",
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40),
                                ),
                              ),
                            ),
                          ),
                        ),
                        signUp
                            ? Container(
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.white,
                                ),
                                child: const TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: "Confirm Password",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(40),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.only(top: 19),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(signUp ? "SignUp" : "Login"),
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
                                        ? Colors.white
                                        : Color.fromARGB(255, 240, 5, 5),
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
      ),
    );
  }
}
