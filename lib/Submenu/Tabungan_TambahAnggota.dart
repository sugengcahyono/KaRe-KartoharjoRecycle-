import 'package:flutter/material.dart';
import 'package:kare/Submenu/Akun_GantiPassword.dart';
import 'package:kare/APIService.dart';

import 'Akun_DataAdmin.dart';

class Tabungan_TambahAnggota extends StatefulWidget {
  const Tabungan_TambahAnggota({Key? key}) : super(key: key);

  @override
  _Akun_TambahAnggotaState createState() => _Akun_TambahAnggotaState();
}

class _Akun_TambahAnggotaState extends State<Tabungan_TambahAnggota> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final APIService apiService = APIService();

  TextEditingController Emailcontroller = TextEditingController();
  TextEditingController Namacontroller = TextEditingController();
  TextEditingController Passwordcontroller = TextEditingController();
  TextEditingController Alamatcontroller = TextEditingController();
  TextEditingController NoTelpcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Tambah Anggota",
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
                controller: Emailcontroller,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 15),
              TextField(
                controller: Namacontroller,
                decoration: InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 15),
              TextField(
                controller: NoTelpcontroller,
                decoration: InputDecoration(
                  labelText: 'No. Handphone',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 15),
              TextField(
                controller: Alamatcontroller,
                decoration: InputDecoration(
                  labelText: 'Alamat',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 15),
              TextField(
                controller: Passwordcontroller,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.black,
                    ),
                  ),
                ),
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 15),
              TextField(
                obscureText: !_isConfirmPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Konfirmasi Password',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                    icon: Icon(
                      _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.black,
                    ),
                  ),
                ),
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  _tambahAnggota();
                  // Tambahkan logika untuk menyimpan data anggota
                },
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

  void _tambahAnggota() {
    // Implementasi logika untuk menambahkan anggota
  }
}
