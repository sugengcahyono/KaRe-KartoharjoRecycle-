import 'dart:math';

import 'package:flutter/material.dart';

class Kunjungan_DetailPengunjung extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Formulir Pendaftaran',
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 16.0, right: 16.0),
                    child: Text('Nomor Antrian'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      width: 400, // Atur lebar
                      height: 45, // Atur tinggi
                      child: TextFormField(
                        readOnly: true, // Membuat teks hanya baca
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        controller: TextEditingController(
                            text: ''), // Teks yang ingin ditampilkan
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 16.0, right: 16.0),
                    child: Text('Nama'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      width: 400, // Atur lebar
                      height: 45, // Atur tinggi
                      child: TextFormField(
                        readOnly: true, // Membuat teks hanya baca
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        controller: TextEditingController(
                            text: ''), // Teks yang ingin ditampilkan
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 16.0, right: 16.0),
                    child: Text('Asal'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: SizedBox(
                      width: 180, // Atur lebar
                      height: 45, // Atur tinggi
                      child: TextFormField(
                        readOnly: true, // Membuat teks hanya baca
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        controller: TextEditingController(
                            text: ''), // Teks yang ingin ditampilkan
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 16.0, right: 0.0),
                    child: Text('Tanggal'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      width: 180, // Atur lebar
                      height: 45, // Atur tinggi
                      child: TextFormField(
                        readOnly: true, // Membuat teks hanya baca
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        controller: TextEditingController(
                            text: ''), // Teks yang ingin ditampilkan
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 16.0, right: 16.0),
                    child: Text('Jenis Kunjungan'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      width: 400, // Atur lebar
                      height: 45, // Atur tinggi
                      child: TextFormField(
                        readOnly: true, // Membuat teks hanya baca
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        controller: TextEditingController(
                            text: ''), // Teks yang ingin ditampilkan
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 16.0, right: 16.0),
                    child: Text('Nama Instansi'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      width: 400, // Atur lebar
                      height: 45, // Atur tinggi
                      child: TextFormField(
                        readOnly: true, // Membuat teks hanya baca
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        controller: TextEditingController(
                            text: ''), // Teks yang ingin ditampilkan
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 16.0, right: 16.0),
                    child: Text('Jumlah Orang'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      width: 400, // Atur lebar
                      height: 45, // Atur tinggi
                      child: TextFormField(
                        readOnly: true, // Membuat teks hanya baca
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        controller: TextEditingController(
                            text: ''), // Teks yang ingin ditampilkan
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 16.0, right: 16.0),
                    child: Text('No Telepon'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      width: 400, // Atur lebar
                      height: 45, // Atur tinggi
                      child: TextFormField(
                        readOnly: true, // Membuat teks hanya baca
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        controller: TextEditingController(
                            text: ''), // Teks yang ingin ditampilkan
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 16.0, right: 16.0),
                    child: Text('Tujuan Mengunjungi'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      width: 400, // Atur lebar
                      height: 45, // Atur tinggi
                      child: TextFormField(
                        readOnly: true, // Membuat teks hanya baca
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        controller: TextEditingController(
                            text: ''), // Teks yang ingin ditampilkan
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(50, 8, 0, 2)),
                        ElevatedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green),
                              overlayColor: MaterialStateProperty.all<Color>(
                                  Colors.greenAccent),
                            ),
                            onPressed: () {},
                            child: const Text("Diterima")),
                      ]),
                  Padding(padding: EdgeInsets.fromLTRB(50, 8, 0, 2)),
                  ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        overlayColor:
                            MaterialStateProperty.all<Color>(Colors.redAccent),
                      ),
                      onPressed: () {},
                      child: const Text("Ditolak")),
                ]),
          ),
        ),
      ),
    );
  }
}