import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../APIService.dart';
import '../Model/usermodel.dart';

class DetailKegiatanPage extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String deskripsi;
  final int idKegiatan;
  final UserModel userModel;

  const DetailKegiatanPage({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.deskripsi,
    required this.idKegiatan,
    required this.userModel,
  }) : super(key: key);

  @override
  _DetailKegiatanPageState createState() => _DetailKegiatanPageState();
}

class _DetailKegiatanPageState extends State<DetailKegiatanPage> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final APIService _apiService = APIService();
  late File _imageFile = File('');

  // Menambahkan variabel untuk menyimpan nilai awal judul dan deskripsi kegiatan
  late String _initialTitle;
  late String _initialDeskripsi;

  @override
  void initState() {
    super.initState();
    // Set nilai awal controller saat initState
    _judulController.text = widget.title;
    _deskripsiController.text = widget.deskripsi;

    // Simpan nilai awal judul dan deskripsi kegiatan
    _initialTitle = widget.title;
    _initialDeskripsi = widget.deskripsi;
  }

  Future<void> _uploadKegiatan() async {
    if (_judulController.text.isEmpty || _deskripsiController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Harap lengkapi semua field'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Periksa apakah gambar diupdate atau tidak
    if (_imageFile.path.isEmpty && widget.imageUrl == '') {
      // Jika tidak ada gambar yang dipilih dan gambar sebelumnya tidak ada,
      // tampilkan notifikasi bahwa gambar harus diupdate
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gambar harus diupdate'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Menentukan gambar yang akan dikirim ke server
      File selectedImageFile;
      if (_imageFile.path.isNotEmpty) {
        selectedImageFile = _imageFile;
      } else {
        // Jika tidak ada perubahan pada gambar, gunakan gambar sebelumnya
        selectedImageFile = File(widget.imageUrl);
      }

      // Cek apakah ada perubahan pada judul dan deskripsi kegiatan
      if (_judulController.text != _initialTitle ||
          _deskripsiController.text != _initialDeskripsi ||
          _imageFile.path.isNotEmpty) {
        // Jika ada perubahan, kirim permintaan pembaruan ke server
        await _apiService.updateKegiatan(
          widget.idKegiatan,
          _judulController.text,
          _deskripsiController.text,
          selectedImageFile,
          widget.userModel.id,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Kegiatan berhasil diperbarui'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Jika tidak ada perubahan, tampilkan pesan bahwa tidak ada yang diubah
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tidak ada perubahan yang dilakukan'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.blue,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Silahkan gambarupdate  '),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _deleteKegiatan() async {
    // Tampilkan dialog konfirmasi
    bool confirmDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi'),
        content: Text('Apakah Anda yakin ingin menghapus kegiatan ini?'),
        actions: [
          TextButton(
            onPressed: () {
              // Jika pengguna memilih ya, kembalikan nilai true
              Navigator.of(context).pop(true);
            },
            child: Text('Ya'),
          ),
          TextButton(
            onPressed: () {
              // Jika pengguna memilih tidak, kembalikan nilai false
              Navigator.of(context).pop(false);
            },
            child: Text('Tidak'),
          ),
        ],
      ),
    );

    // Periksa apakah pengguna telah mengonfirmasi penghapusan
    if (confirmDelete == true) {
      try {
        final _apiService = APIService();
        await _apiService.deleteKegiatan(widget.idKegiatan);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Kegiatan berhasil dihapus'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
        // Kembali ke halaman sebelumnya setelah menghapus kegiatan
        Navigator.of(context).pop(true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menghapus kegiatan'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _resetForm() {
    setState(() {
      _imageFile = File('');
      _judulController.clear();
      _deskripsiController.clear();
    });
  }

  // Tambahkan fungsi untuk mengambil gambar dari galeri
  Future<void> _pickImage() async {
    final imageFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        _imageFile = File(imageFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Detail Kegiatan",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _deleteKegiatan,
          ),
        ],
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
                      : Image.network(
                          widget.imageUrl,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _judulController, // Gunakan controller
                decoration: InputDecoration(
                  labelText: 'Judul Kegiatan',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _deskripsiController, // Gunakan controller
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
                child: Text(
                  'Simpan Perubahan',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20 // Ubah warna teks menjadi putih
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
