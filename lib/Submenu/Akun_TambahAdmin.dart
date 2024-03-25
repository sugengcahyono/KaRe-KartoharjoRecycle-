import 'package:flutter/material.dart';
import 'package:kare/Submenu/Akun_GantiPassword.dart';
import 'package:kare/APIService.dart';

import 'Akun_DataAdmin.dart';

class Akun_TambahAkun extends StatefulWidget {
  const Akun_TambahAkun({Key? key}) : super(key: key);

  @override
  _Akun_TambahAkunState createState() => _Akun_TambahAkunState();
}

class _Akun_TambahAkunState extends State<Akun_TambahAkun> {
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
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                "Tambah Admin",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                // Tambahkan logika untuk setiap opsi yang dipilih di sini
                print(value);
                if (value == 'Data Admin') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DataAdminPage()),
                  );
                }
              },
              itemBuilder: (BuildContext context) {
                return ['Data Admin'].map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
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
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/foto_coba1.jpg'),
                    ),
                    SizedBox(height: 5),
                    TextButton(
                      onPressed: () {
                        // Aksi yang dijalankan ketika teks ditekan
                      },
                      child: Text(
                        'Unggah Foto',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
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
                        _tambahAdmin();
                        // Tambahkan logika untuk menyimpan data admin
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
            ],
          ),
        ),
      ),
    );
  }

  void _tambahAdmin() {
    String email = Emailcontroller.text;
    String nama_user = Namacontroller.text;
    String password = Passwordcontroller.text;
    String alamat_user = Alamatcontroller.text;
    String notelp_user = NoTelpcontroller.text;

    // Validasi data admin di sini jika diperlukan

    // Memanggil fungsi TambahAkun dari APIService
    apiService.tambahAdmin2(email, password, nama_user, alamat_user, notelp_user)
      .then((response) {
        // Handle respon dari server sesuai kebutuhan
        print(response);
        // Tampilkan pesan sukses atau lakukan tindakan lain yang sesuai
      })
      .catchError((error) {
        // Handle kesalahan yang mungkin terjadi
        print('Error: $error');
        // Tampilkan pesan kesalahan kepada pengguna jika diperlukan
      });
  }
}
