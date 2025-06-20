import 'package:flutter/material.dart';
import 'package:votting_systems/chatbotai.dart';
import 'package:votting_systems/presenation/ipscreen.dart';
import 'package:votting_systems/presenation/signinscreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: IpScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

