import 'package:flutter/material.dart';

class BerandaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF21690F), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50), // Spasi atas
                Text(
                  'Beranda',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20), // Spasi
                // Container 1 - Berat Sampah
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Berat Sampah',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      // Tambahkan konten berat sampah disini
                    ],
                  ),
                ),
                // Container 2 - Upload Kegiatan
                GestureDetector(
                  onTap: () {
                    // Do something when "Upload Kegiatan" is clicked
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        // Gambar Upload Kegiatan
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Icon(Icons.upload, color: Colors.white),
                        ),
                        // Text Upload Kegiatan
                        Text('Upload Kegiatan', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                // Container 3 - Upload Pupuk
                GestureDetector(
                  onTap: () {
                    // Do something when "Upload Pupuk" is clicked
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        // Gambar Upload Pupuk
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Icon(Icons.upload, color: Colors.white),
                        ),
                        // Text Upload Pupuk
                        Text('Upload Pupuk', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle refresh action
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
