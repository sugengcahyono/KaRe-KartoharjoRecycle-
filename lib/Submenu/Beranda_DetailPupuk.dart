import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../APIService.dart';
import '../Model/usermodel.dart';

class DetailPupukPage extends StatefulWidget {
  final String imageUrl;
  final String title;
  final int harga;
  final int stok;
  final String deskripsi;
  final int idPupuk;
  final UserModel userModel;

  const DetailPupukPage({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.harga,
    required this.stok,
    required this.deskripsi,
    required this.idPupuk,
    required this.userModel,
  }) : super(key: key);

  @override
  _DetailPupukPageState createState() => _DetailPupukPageState();
}

class _DetailPupukPageState extends State<DetailPupukPage> {
  final TextEditingController _namapupukController = TextEditingController();
  final TextEditingController _hargapupukController = TextEditingController();
  final TextEditingController _stokpupukController = TextEditingController();
  final TextEditingController _deskripsipupukController =
      TextEditingController();
  final APIService _apiService = APIService();
  late File _imageFile = File('');

  // Menambahkan variabel untuk menyimpan nilai awal judul dan deskripsi kegiatan
  late String _initialnamapupuk;
  late String _initialhargapupuk;
  late String _initialstokpupuk;
  late String _initialdeskripsipupuk;

  @override
  void initState() {
    super.initState();
    // Set nilai awal controller saat initState
    _namapupukController.text = widget.title;
    _hargapupukController.text = widget.harga.toString();
    _stokpupukController.text = widget.stok.toString();
    _deskripsipupukController.text = widget.deskripsi;

    // Simpan nilai awal judul dan deskripsi kegiatan
    _initialnamapupuk = widget.title;
    _initialhargapupuk = widget.harga.toString();
    _initialstokpupuk = widget.stok.toString();
    _initialdeskripsipupuk = widget.deskripsi;
  }

  Future<void> _updatePupuk() async {
  if (_namapupukController.text.isEmpty ||
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

    // Konversi teks menjadi bilangan bulat
    int stokPupuk = int.parse(_stokpupukController.text);
    int hargaPupuk = int.parse(_hargapupukController.text);

    // Memanggil metode update dengan parameter yang sesuai
    
    await _apiService.updatePupuk(
      widget.idPupuk,
      _namapupukController.text,
      hargaPupuk,
      stokPupuk,
      _deskripsipupukController.text,
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
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Gambar harus diupdate'),
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
        await _apiService.deletePupuk(widget.idPupuk);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Pupuk berhasil dihapus'),
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
      _namapupukController.clear();
      _hargapupukController.clear();
      _stokpupukController.clear();
      _deskripsipupukController.clear();
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
          "Detail Pupuk",
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
                onPressed: _updatePupuk, // Hapus tanda kurung ()
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
                  'Simpan Perubahan',
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
