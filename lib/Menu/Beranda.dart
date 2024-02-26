import 'package:flutter/material.dart';

class BerandaPage extends StatelessWidget {
  // Contoh nama pengguna
  final String namaPengguna = "John";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20), // Spasi atas
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hallo, $namaPengguna',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          SizedBox(height: 15),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Lihat Aktivitasmu dan Kelola TPST\n',
                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                ),
                                TextSpan(
                                  text: 'Kartoharjo',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25), // Spasi
                    // Container 1 - Berat Sampah per Hari
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: 120,
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Berat Sampah Per-Hari',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '100 kg', // Atur nominal berat di sini
                                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Image.asset(
                              'assets/icons/recycle-bin.png',
                              width: 70, // Atur lebar gambar
                              height: 70, // Atur tinggi gambar
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Container 2 - Berat Sampah per Bulan
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 120,
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Per-Bulan',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '500 kg', // Atur nominal berat di sini
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              // Tambahkan konten berat sampah per bulan disini
                            ],
                          ),
                        ),
                        // Container 3 - Berat Sampah per Tahun
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 120,
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Per-Tahun',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '1000 kg', // Atur nominal berat di sini
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              // Tambahkan konten berat sampah per tahun disini
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15), // Spasi antara konten
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Aktivitas',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          SizedBox(height: 10),
                         
                        ],
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                       Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 120,
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/icons/camera.png', // Ubah path gambar sesuai kebutuhan
                                width: 70, // Sesuaikan lebar gambar
                                height: 70, // Sesuaikan tinggi gambar
                              ),
                              SizedBox(width: 20), // Spasi antara gambar dan teks
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Per-Bulan',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    '500 kg', // Atur nominal berat di sini
                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  // Tambahkan konten berat sampah per bulan disini
                                ],
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                       Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 120,
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/icons/fertilizer.png', // Ubah path gambar sesuai kebutuhan
                                width: 70, // Sesuaikan lebar gambar
                                height: 70, // Sesuaikan tinggi gambar
                              ),
                              SizedBox(width: 20), // Spasi antara gambar dan teks
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Per-Bulan',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    '500 kg', // Atur nominal berat di sini
                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  // Tambahkan konten berat sampah per bulan disini
                                ],
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                    // Tempatkan konten aktivitas di sini
                  ],
                ),
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
      ),
    );
  }
}
