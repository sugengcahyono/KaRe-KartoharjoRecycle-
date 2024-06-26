import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../APIService.dart';
import '../Model/usermodel.dart'; // Import package image_picker

class UploadPupukPage extends StatefulWidget {
  final UserModel userModel;
  const UploadPupukPage({Key? key, required this.userModel}) : super(key: key);

  @override
  _UploadPupukPageState createState() => _UploadPupukPageState();
}

class _UploadPupukPageState extends State<UploadPupukPage> {
  final TextEditingController _namapupukController = TextEditingController();
  final TextEditingController _hargapupukController = TextEditingController();
  final TextEditingController _stokpupukController = TextEditingController();
  final TextEditingController _deskripsipupukController = TextEditingController();
  final APIService _apiService = APIService(); // Inisialisasi APIService
  late File _imageFile = File('');

  // Metode untuk memilih gambar dari galeri
  Future<void> _pickImage() async {
    final imageFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        _imageFile = File(imageFile.path);
      });
    }
  }

  Future<void> _uploadPupuk() async {
  if (_imageFile.path.isEmpty ||
      _namapupukController.text.isEmpty ||
      _hargapupukController.text.isEmpty ||
      _stokpupukController.text.isEmpty ||
      _deskripsipupukController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Harap lengkapi semua field'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  try {
    await _apiService.uploadPupuk(
        _namapupukController.text,
        _deskripsipupukController.text,
        _hargapupukController.text,
        _stokpupukController.text,
        _imageFile,
        widget.userModel.id); // Gunakan id_user dari UserModel
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Pupuk berhasil diunggah'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
    _resetForm();
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Gagal mengunggah Pupuk: $e'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }
}


  void _resetForm() {
    setState(() {
      _imageFile = File('');
      _namapupukController.clear();
      _hargapupukController.clear();
      _stokpupukController.clear();
      _deskripsipupukController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Unggah Pupuk",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius:
                        BorderRadius.circular(10), // Mengatur sudut bulat kotak
                    boxShadow: [
                      // Menambahkan bayangan lembut
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: _imageFile.path.isNotEmpty
                      ? Image.file(
                          _imageFile,
                          fit: BoxFit.cover,
                        )
                      : Center(
                          child: Text(
                            'Unggah Foto',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _namapupukController,
                decoration: InputDecoration(
                  labelText: 'Nama Pupuk',
                  border: OutlineInputBorder(),
                ),
                maxLines: null, // Membuat judul bisa multi-line
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _hargapupukController,
                maxLines: null, // Membuat deskripsi bisa multi-line
                keyboardType:
                    TextInputType.number, // Mengubah keyboard menjadi multiline
                decoration: InputDecoration(
                  labelText: 'Harga Pupuk',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _stokpupukController,
                maxLines: null, // Membuat deskripsi bisa multi-line
                keyboardType:
                    TextInputType.number, // Mengubah keyboard menjadi multiline
                decoration: InputDecoration(
                  labelText: 'Stok Pupuk',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _deskripsipupukController,
                maxLines: null, // Membuat deskripsi bisa multi-line
                keyboardType: TextInputType
                    .multiline, // Mengubah keyboard menjadi multiline
                decoration: InputDecoration(
                  labelText: 'Deskripsi Pupuk',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                onPressed: _uploadPupuk, // Hapus tanda kurung ()
                style: ElevatedButton.styleFrom(
                  primary: Color(
                      0xFF21690F), // Ubah warna tombol menjadi hijau gelap
                  shape: RoundedRectangleBorder(
                    // Menyesuaikan bentuk pinggiran tombol
                    borderRadius: BorderRadius.circular(
                        8), // Menyesuaikan tingkat kebulatan pinggiran
                  ),
                ),
                child: Text(
                  'Unggah',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20 // Ubah warna teks menjadi putih
                      ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
