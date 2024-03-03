import 'package:flutter/material.dart';

import 'Beranda_TambahKegiatan.dart';
import 'Beranda_TambahPupuk.dart';

class Berada_Pupuk extends StatelessWidget {
  const Berada_Pupuk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight), // Menyesuaikan tinggi AppBar
        child: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            "Pupuk",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.assignment_add),
              onPressed: () {
                Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UplodPupukPage()),
                          );
                
                // Aksi untuk menambah kegiatan
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), // Padding atas lebih besar
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black), // Memberikan border hitam pada TextField
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0), // Padding horizontal untuk TextField
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Cari Pupuk',
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                          border: InputBorder.none, // Menghilangkan border internal TextField
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.0), // Spasi antara pencarian dan daftar kegiatan
            Expanded(
              child: ListView(
                children: [
                  // Contoh daftar kegiatan (ganti dengan data yang sesuai)
                  _buildKegiatanCard(
                    AssetImage('assets/images/foto_coba1.jpg'), // Gambar kegiatan
                    'Kegiatan 1', // Judul kegiatan
                  ),
                  _buildKegiatanCard(
                    AssetImage('assets/images/foto_coba1.jpg'),
                    'Kegiatan 2',
                  ),
                  _buildKegiatanCard(
                    AssetImage('assets/images/foto_coba1.jpg'),
                    'Kegiatan 3',
                  ),
                  // Tambahkan kegiatan lainnya di sini sesuai kebutuhan
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKegiatanCard(ImageProvider<Object> image, String title) {
    return Card(
      margin: EdgeInsets.only(bottom: 20.0),
      child: InkWell(
        onTap: () {
          // Aksi ketika card kegiatan ditekan
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start, // Mengatur agar judul berada di atas
            children: [
              Container(
                width: 100.0, // Ukuran gambar
                height: 100.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10.0), // Spasi antara gambar dan judul
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
