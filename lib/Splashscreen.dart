import 'package:flutter/material.dart';

import 'Home.dart';
import 'login.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
 void initState() {
  super.initState();
  _navigatetohome();

 }

_navigatetohome() async {
  await Future.delayed(Duration(milliseconds: 2000));
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => Login(), // Mengarahkan ke halaman login
    ),
  );
}


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body:Center(
        child: Container(
          child: Image.asset(
            "assets/images/logo_kare1.png"
          ),
        ),
      ),
    );
  }
}