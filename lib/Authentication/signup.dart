import 'package:flutter/cupertino.dart';
import 'package:whatsapp_live_caption/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isSignup = true; // Toggle state for Signup/Login
  void onSubmit(){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(left: 40, right: 40),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(isSignup ?
                'signup.jpg' : 'login.jpg',
              width: 200,
              height: 200,
              ),
              Text(
                isSignup ? "Signup" : "Login", // Toggle Text
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 500,
                child: Column(
                  children: [
                    if (isSignup) // Show Name field only for Signup
                      Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              hintText: "Enter Name",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                borderSide: BorderSide(width: 1, color: Colors.greenAccent),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(width: 1, color: Colors.blueAccent),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Enter Email",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          borderSide: BorderSide(width: 1, color: Colors.greenAccent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1, color: Colors.blueAccent),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          borderSide: BorderSide(width: 1, color: Colors.greenAccent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1, color: Colors.blueAccent),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Social Media Login Buttons
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 45,
                            child: TextButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.grey[200]),
                                padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                                foregroundColor: MaterialStateProperty.all(Colors.black),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    side: BorderSide(color: Colors.black54),
                                  ),
                                ),
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'Google.webp',
                                      width: 30,
                                      height: 30,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "With Google",
                                      style: GoogleFonts.poppins(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            height: 45,
                            child: TextButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.grey[200]),
                                padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                                foregroundColor: MaterialStateProperty.all(Colors.black),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    side: BorderSide(color: Colors.black54),
                                  ),
                                ),
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'facebook.jpeg',
                                      width: 30,
                                      height: 30,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "With Facebook",
                                      style: GoogleFonts.poppins(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Submit Button
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: onSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text(
                          isSignup ? "Sign Up" : "Login",
                          style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),

                    // Switch between Signup and Login
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isSignup = !isSignup; // Toggle state
                        });
                      },
                      child: Text(
                        isSignup ? "Already have an account? Login" : "Don't have an account? Sign Up",
                        style: GoogleFonts.poppins(fontSize: 14, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
