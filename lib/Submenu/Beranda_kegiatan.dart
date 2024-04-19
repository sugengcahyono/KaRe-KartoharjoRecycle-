import 'package:flutter/material.dart';

import 'Beranda_TambahKegiatan.dart';
import '../Model/usermodel.dart'; // Impor UserModel

class Berada_Kegiatan extends StatelessWidget {
  final UserModel userModel; // Tambahkan userModel sebagai properti

  const Berada_Kegiatan({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            "Kegiatan",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.add_a_photo_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UploadKegiatanPage(userModel: userModel), // Sediakan userModel saat menavigasi
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Cari Kegiatan',
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: ListView(
                children: [
                  _buildKegiatanCard(
                    AssetImage('assets/images/foto_coba1.jpg'),
                    'Kegiatan 1',
                  ),
                  _buildKegiatanCard(
                    AssetImage('assets/images/foto_coba1.jpg'),
                    'Kegiatan 2',
                  ),
                  _buildKegiatanCard(
                    AssetImage('assets/images/foto_coba1.jpg'),
                    'Kegiatan 3',
                  ),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10.0),
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
