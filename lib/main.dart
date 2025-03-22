import 'package:flutter/material.dart';
import 'package:whatsapp_live_caption/home.dart';
import 'package:whatsapp_live_caption/splash.dart';
import 'package:whatsapp_live_caption/Authentication/signup.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    // home: Login(),
    home: Login(),
  ));
}
// -----------------------------------------
// Firebse Edition
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:whatsapp_live_caption/Authentication/Auth.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(home: AuthScreen()));
// }
