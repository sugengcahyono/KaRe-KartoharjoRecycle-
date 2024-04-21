import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../APIService.dart';
import '../Model/usermodel.dart'; // Sesuaikan dengan struktur proyek Anda
 // Sesuaikan dengan struktur proyek Anda

class UploadKegiatanPage extends StatefulWidget {
  final UserModel userModel; // Tambahkan UserModel sebagai parameter

  const UploadKegiatanPage({Key? key, required this.userModel}) : super(key: key);

  @override
  _UploadKegiatanPageState createState() => _UploadKegiatanPageState();
}

class _UploadKegiatanPageState extends State<UploadKegiatanPage> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final APIService _apiService = APIService(); // Inisialisasi APIService
  late File _imageFile = File('');

  Future<void> _pickImage() async {
    final imageFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        _imageFile = File(imageFile.path);
      });
    }
  }

  Future<void> _uploadKegiatan() async {
    if (_imageFile.path.isEmpty || _judulController.text.isEmpty || _deskripsiController.text.isEmpty) {
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
      await _apiService.uploadKegiatan(_judulController.text, _deskripsiController.text, _imageFile, widget.userModel.id); // Gunakan id_user dari UserModel
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Kegiatan berhasil diunggah'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
      _resetForm();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal mengunggah kegiatan: $e'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _resetForm() {
    setState(() {
      _imageFile = File('');
      _judulController.clear();
      _deskripsiController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Unggah Kegiatan",
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 3),
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
              SizedBox(height: 20),
              TextField(
                controller: _judulController,
                decoration: InputDecoration(
                  labelText: 'Judul Kegiatan',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _deskripsiController,
                decoration: InputDecoration(
                  labelText: 'Deskripsi Kegiatan',
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _uploadKegiatan,
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF21690F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Unggah',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
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
