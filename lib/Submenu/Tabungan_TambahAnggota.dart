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
  TextEditingController ConfirmPasswordcontroller = TextEditingController();
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
                keyboardType: TextInputType.number,
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
                controller: ConfirmPasswordcontroller,
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

  void _tambahAnggota() async {
  String email = Emailcontroller.text;
  String nama_user = Namacontroller.text;
  String password = Passwordcontroller.text;
  String confirmPassword = ConfirmPasswordcontroller.text;
  String alamat_user = Alamatcontroller.text;
  String notelp_user = NoTelpcontroller.text;
  
  try {
    // Validasi email
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Masukkan email dengan format yang benar'),
        ),
      );
      return;
    }

    // Validasi nama (minimal 3 karakter, maksimal 50 karakter, tidak boleh mengandung angka)
    if (nama_user.length < 3 || nama_user.length > 50 || RegExp(r'\d').hasMatch(nama_user)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Nama harus terdiri dari 3-50 karakter dan tidak boleh mengandung angka'),
        ),
      );
      return;
    }

    // Validasi nomor handphone (minimal 11 dan maksimal 13 karakter)
    if (notelp_user.length < 11 || notelp_user.length > 13) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Nomor handphone harus terdiri dari 11-13 karakter Angka'),
        ),
      );
      return;
    }

    // Validasi alamat
    if (alamat_user.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Alamat harus diisi'),
        ),
      );
      return;
    }
    // Validasi alamat (maksimal 100 karakter)
    if (alamat_user.length > 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Alamat maksimal 100 karakter'),
        ),
      );
      return;
    }

    // Validasi password
    if (password.isEmpty || password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password minimal terdiri dari 6 karakter'),
        ),
      );
      return;
    }

    // Validasi konfirmasi password
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Konfirmasi password tidak sesuai'),
        ),
      );
      return;
    }

    // Jika semua validasi terpenuhi, lanjutkan dengan operasi tambah anggota
    final response = await apiService.tambahAnggota(
      email,
      password,
      nama_user,
      alamat_user,
      notelp_user,
    );

    if (response['status'] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data Anggota berhasil disimpan'),
        ),
      );
      // Navigasi ke halaman data admin atau lainnya jika diperlukan
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menyimpan data Anggota'),
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Terjadi kesalahan saat menyimpan data admin: $e'),
      ),
    );
  }
}

}
