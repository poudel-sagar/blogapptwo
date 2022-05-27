import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'pages/HomePage.dart';
import 'pages/WelcomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = WelcomePage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
  }

 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Moru Blog App',
        theme: ThemeData(
          textTheme: GoogleFonts.openSansTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: page);
  }
}

