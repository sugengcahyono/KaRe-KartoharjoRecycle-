import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import package image_picker

class UplodPupukPage extends StatelessWidget {
  late XFile? _imageFile = null; // Inisialisasi variabel _imageFile dengan null

  // Metode untuk memilih gambar dari galeri
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _imageFile = image;
    }
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
            Navigator.of(context).pop();
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
                    borderRadius: BorderRadius.circular(10), // Mengatur sudut bulat kotak
                    boxShadow: [ // Menambahkan bayangan lembut
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: _imageFile != null
                      ? Image.file(
                          File(_imageFile!.path),
                          fit: BoxFit.cover,
                        )
                      : Icon(Icons.add_a_photo, size: 100, color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
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
                maxLines: null, // Membuat deskripsi bisa multi-line
                keyboardType: TextInputType.multiline, // Mengubah keyboard menjadi multiline
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
              onPressed: () {
              
              },
               style: ElevatedButton.styleFrom(
                primary: Color(0xFF21690F), // Ubah warna tombol menjadi hijau gelap
                shape: RoundedRectangleBorder( // Menyesuaikan bentuk pinggiran tombol
                  borderRadius: BorderRadius.circular(8), // Menyesuaikan tingkat kebulatan pinggiran
                ),),
              child: Text(
                'Unggah',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white, fontSize: 20 // Ubah warna teks menjadi putih
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


