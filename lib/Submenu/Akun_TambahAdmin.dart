import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kare/Submenu/Akun_GantiPassword.dart';
import 'package:kare/APIService.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'Akun_DataAdmin.dart';

class Akun_TambahAkun extends StatefulWidget {
  const Akun_TambahAkun({Key? key}) : super(key: key);

  @override
  _Akun_TambahAkunState createState() => _Akun_TambahAkunState();
}

class _Akun_TambahAkunState extends State<Akun_TambahAkun> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  File? _imageFile; // File untuk menyimpan foto profil yang dipilih

  final APIService apiService = APIService();

  TextEditingController Emailcontroller = TextEditingController();
  TextEditingController Namacontroller = TextEditingController();
  TextEditingController Passwordcontroller = TextEditingController();
  TextEditingController Passwordkonfircontroller = TextEditingController();
  TextEditingController Alamatcontroller = TextEditingController();
  TextEditingController NoTelpcontroller = TextEditingController();

  Future<void> _getImageFromGallery() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _imageFile = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _getImageFromCamera() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.camera);

    setState(() {
      if (pickedImage != null) {
        _imageFile = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Tambah Admin",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 30),
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      _showImagePicker(); // Memanggil fungsi untuk memilih foto profil
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!) as ImageProvider<Object>
                          : AssetImage('assets/images/default_profil1.png'),
                    ),
                  ),
                  SizedBox(height: 5),
                  TextButton(
                    onPressed: () {
                      _showImagePicker(); // Memanggil fungsi untuk memilih foto profil
                    },
                    child: Text(
                      'Unggah Foto',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: Emailcontroller,
                    keyboardType: TextInputType
                        .emailAddress, // Menandakan bahwa input harus berupa email
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: "admin@gmail.com",
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
                    maxLength: 50,
                    keyboardType: TextInputType.name,
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
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'No. Handphone',
                      hintText: "08581234XXX",
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
                    maxLength: 80,
                    keyboardType: TextInputType.streetAddress,
                    maxLines:
                        null, // TextField akan beralih ke mode multiline jika diperlukan
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
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: Passwordkonfircontroller,
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
                            _isConfirmPasswordVisible =
                                !_isConfirmPasswordVisible;
                          });
                        },
                        icon: Icon(
                          _isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      _tambahAdmin2();
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
    );
  }

  void _showImagePicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Pilih Sumber Gambar"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text("Galeri"),
                onTap: () {
                  Navigator.pop(context);
                  _getImageFromGallery();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text("Kamera"),
                onTap: () {
                  Navigator.pop(context);
                  _getImageFromCamera();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Fungsi untuk menambahkan admin
  void _tambahAdmin2() async {
  String email = Emailcontroller.text;
  String nama_user = Namacontroller.text;
  String password = Passwordcontroller.text;
  String passwordkonfir = Passwordkonfircontroller.text;
  String alamat_user = Alamatcontroller.text;
  String notelp_user = NoTelpcontroller.text;
  File? foto_user = _imageFile; // Gunakan tipe File untuk foto

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

    // Validasi nama (maksimal 50 karakter)
    if (nama_user.isEmpty || nama_user.length > 50) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Nama harus diisi dan maksimal 50 karakter'),
        ),
      );
      return;
    }

    // Validasi nomor handphone (minimal 11 dan maksimal 13 karakter)
    if (notelp_user.length < 11 || notelp_user.length > 13) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Nomor handphone harus terdiri dari 11-13 karakter Angka'),
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
    if (password != passwordkonfir) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Konfirmasi password tidak sesuai'),
        ),
      );
      return;
    }

    // Validasi apakah gambar telah dipilih
    if (foto_user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pilih gambar profil terlebih dahulu'),
        ),
      );
      return;
    }

    // Jika semua validasi terpenuhi, lanjutkan dengan operasi tambah admin
    final response = await apiService.tambahAdmin2(
      email,
      password,
      nama_user,
      alamat_user,
      notelp_user,
      foto_user, // Kirim foto sebagai File
    );

    if (response['status'] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data admin berhasil disimpan'),
        ),
      );
      // Navigasi ke halaman data admin atau lainnya jika diperlukan
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menyimpan data admin'),
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
