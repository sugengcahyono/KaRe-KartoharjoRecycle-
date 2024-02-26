import 'package:flutter/material.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  // List of controllers for OTP fields
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    // Initialize the list of controllers
    _controllers = List.generate(6, (index) => TextEditingController());
  }

  @override
  void dispose() {
    // Dispose all controllers when the widget is disposed
    _controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

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
              'Masukkan OTP',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Silahkan masukkan kode OTP yang telah dikirimkan ke email anda.',
              style: TextStyle(fontSize: 16, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                6,
                (index) => SizedBox(
                  width: 50,
                  child: TextFormField(
                    controller: _controllers[index],
                    maxLength: 1,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.length == 1 && index < 5) {
                        // Move focus to the next field if a digit is entered
                        FocusScope.of(context).nextFocus();
                      }
                      if (value.isEmpty && index > 0) {
                        // Move focus to the previous field if backspace is pressed
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Action ketika tombol "Verifikasi" diklik
                // Collect OTP from all fields
                String otp = '';
                _controllers.forEach((controller) => otp += controller.text);
                print('OTP entered: $otp');
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
                'Verifikasi',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20, // Ubah warna teks menjadi putih
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
