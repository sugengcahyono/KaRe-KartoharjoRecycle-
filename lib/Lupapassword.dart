import 'package:flutter/material.dart';
import 'package:kare/OtpPage.dart';
import 'APIService.dart';
import 'Model/usermodel.dart';

class Lupapassword extends StatefulWidget {
  static String Email = "";
  @override
  _LupapasswordState createState() => _LupapasswordState();
}

class _LupapasswordState extends State<Lupapassword> {
  final APIService _apiService = APIService();
  TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';
  late UserModel _userModel;

  Future<void> _sendOTP() async {
    setState(() {
      _isLoading = true;
    });

    var email = _emailController.text;
Lupapassword.Email = email;
    try {
      var result = await _apiService.checkEmail(email);

      setState(() {
        _isLoading = false;
      });

      if (result != null && result['success']) {
        _userModel = UserModel(
          id: result['data']['id_user'] ?? 0,
          email: result['data']['email_user'] ?? '',
          nama: result['data']['nama_user'] ?? '',
          alamat: result['data']['alamat_user'] ?? '',
          noTelp: result['data']['notelp_user'] ?? '',
          foto: result['data']['foto_user'] ?? '',
          level: result['data']['level_user'] ?? '',
          message: result['message'] ?? '',
          otp: result['data']['otp'] ?? '', // Simpan OTP di UserModel
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OtpPage(userModel: _userModel)),
        );
      } else {
        setState(() {
          _errorMessage = result != null ? result['error'] : 'Failed to fetch data';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_errorMessage),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'An error occurred: $error';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_errorMessage),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
    }
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
              controller: _emailController,
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
              onPressed: _isLoading ? null : _sendOTP,
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF21690F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: _isLoading
                  ? CircularProgressIndicator()
                  : Text(
                      'Selanjutnya',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
