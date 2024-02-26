import 'package:flutter/material.dart';
import 'package:kare/OtpPage.dart';

class Lupapassword extends StatefulWidget {
  @override
  _LupapasswordState createState() => _LupapasswordState();
}

class _LupapasswordState extends State<Lupapassword> {
  bool _isObscure = true; // State variable to toggle password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Lupa Password',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Silahkan masukkan alamat Email anda yang sudah terdaftar',
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
            SizedBox(height: 10),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Action ketika tombol "Selanjutnya" diklik
                Navigator.push(
                     // Action ketika tombol "Lupa Password" diklik
                    context,
                    MaterialPageRoute(builder: (context) => OtpPage()), // Ganti LupaPasswordScreen dengan nama kelas layar Anda
                  );
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF21690F), // Ubah warna tombol menjadi hijau gelap
                shape: RoundedRectangleBorder(
                  // Menyesuaikan bentuk pinggiran tombol
                  borderRadius: BorderRadius.circular(8),
                  // Menyesuaikan tingkat kebulatan pinggiran
                ),
              ),
              child: Text(
                'Selanjutnya',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20 // Ubah warna teks menjadi putih
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
