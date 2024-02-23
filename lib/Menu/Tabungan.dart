import 'package:flutter/material.dart';
import 'package:kare/Lupapassword.dart';

import '../Widget01.dart';


class Tabungan extends StatefulWidget {

    _LoginState createState() => _LoginState();

}

class _LoginState extends State<Tabungan> {

  bool _isObscure = true; // State variable to toggle password visibility
  @override
  Widget build(BuildContext context) {
        return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Tabungan",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false, // Menghilangkan tombol kembali
      ),
    );
  }
}
