import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FoundPage extends StatelessWidget {
  const FoundPage({Key? key}) : super(key: key);

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
              // decoration: const BoxDecoration(color: Color.fromARGB(255, 127, 244, 95)),
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                    child: Center(
                      child: Text(
                        "Found It",
                        style: GoogleFonts.teko(fontSize: 44),
                      ),
                    ),
                  ),
                   Container(
                          width: 180, // Increase the width of the button
                          height: 140, // Increase the height of the button
                          child: ElevatedButton(
                            onPressed: () {},
                         child: const Text(
                        "Choose Image",
                            style: TextStyle(fontSize: 20),
                        ),
                            ),
                          ),

                 SizedBox(
                    height: 400, // Double the height of the container
                    width: 350, // Increase the width of the container
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 120, // Double the height of the input box
                          width: 450 , // Increase the width of the input box
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: const TextField(
                            maxLines: 6, // Allow for more lines of text
                            decoration: InputDecoration(
                              hintText: "Give the Description of the item found...",
                              hintStyle: TextStyle(fontSize: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
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
                            decoration: InputDecoration(
                                 hintText: "Enter The Location",
                                  hintStyle: TextStyle(fontSize: 20),
                                    border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40),
                                ),
                              ),
                            ),
                          ),
                        ),
                      
                        ElevatedButton(
                          onPressed: () {},
                         child: const Text(
                        "POST",
                            style: TextStyle(fontSize: 20),
                        ),                        
                       ),
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







