import 'package:flutter/material.dart';
import 'APIService.dart';
import 'Login.dart';
import 'Model/usermodel.dart';

class GantiPassword extends StatefulWidget {
  final UserModel userModel;

  GantiPassword({required this.userModel});

  @override
  _GantiPasswordState createState() => _GantiPasswordState();
}

class _GantiPasswordState extends State<GantiPassword> {
  late APIService _apiService;

  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _apiService = APIService();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _toggleNewPasswordVisibility() {
    setState(() {
      _obscureNewPassword = !_obscureNewPassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  void _changePassword() {
  String newPassword = _newPasswordController.text;
  String confirmPassword = _confirmPasswordController.text;

  // Check if the new password meets the minimum length requirement
  if (newPassword.length < 6) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Password harus terdiri dari minimal 6 karakter.'),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  // Check if new password and confirm password match
  if (newPassword != confirmPassword) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Password baru dan konfirmasi password baru tidak cocok.'),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  _apiService.updatePassword(widget.userModel.email, newPassword).then((response) {
    if (response['success'] != null && response['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password berhasil diubah."),
          duration: Duration(seconds: 3),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } else {
      String errorMessage = response['message'] ?? "Terjadi kesalahan.";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
    }
  }).catchError((error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Terjadi kesalahan: $error"),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
      ),
    );
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Ubah Password",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 30),
              TextField(
                controller: _newPasswordController,
                obscureText: _obscureNewPassword,
                decoration: InputDecoration(
                  labelText: 'Password Baru',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureNewPassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: _toggleNewPasswordVisibility,
                  ),
                ),
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'Konfirmasi Password Baru',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureConfirmPassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: _toggleConfirmPasswordVisibility,
                  ),
                ),
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: _changePassword,
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF21690F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Simpan',
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
      ),
    );
  }
}
