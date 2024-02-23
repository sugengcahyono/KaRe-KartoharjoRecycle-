import 'package:flutter/material.dart';
import 'package:kare/Lupapassword.dart';

import 'Widget01.dart';


class Login extends StatefulWidget {

    _LoginState createState() => _LoginState();

}

class _LoginState extends State<Login> {

  bool _isObscure = true; // State variable to toggle password visibility
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Masuk',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Senang melihatmu lagi! Masuk dan mulailah mengelola TPST Kartoharjo',
              style: TextStyle(fontSize: 16, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.black,
                ),
              ),
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 20),
            TextField(
              obscureText: _isObscure,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure; // Toggle password visibility
                    });
                  },
                ),
              ),
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                     // Action ketika tombol "Lupa Password" diklik
                    context,
                    MaterialPageRoute(builder: (context) => Lupapassword()), // Ganti LupaPasswordScreen dengan nama kelas layar Anda
                  );
                },
                child: Text(
                  'Lupa Password',
                  style: TextStyle(color: Colors.black, decoration: TextDecoration.underline, fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
               Navigator.push(
                     // Action ketika tombol "Lupa Password" diklik
                    context,
                    MaterialPageRoute(builder: (context) => MyWidget()),
                  );
              },
               style: ElevatedButton.styleFrom(
                primary: Color(0xFF21690F), // Ubah warna tombol menjadi hijau gelap
                shape: RoundedRectangleBorder( // Menyesuaikan bentuk pinggiran tombol
                  borderRadius: BorderRadius.circular(8), // Menyesuaikan tingkat kebulatan pinggiran
                ),),
              child: Text(
                'Masuk',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white, fontSize: 20 // Ubah warna teks menjadi putih
                ),
              ), 
            ),
          ],
        ),
      ),
    );
  }
}
