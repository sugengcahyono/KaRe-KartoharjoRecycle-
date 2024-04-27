import 'dart:math';

import 'package:flutter/material.dart';

class Kunjungan_DetailPengunjung extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Formulir Pendaftaran',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 50), // Mengatur jarak dari kiri
                      ElevatedButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green),
                            overlayColor: MaterialStateProperty.all<Color>(
                                Colors.greenAccent),
                          ),
                          onPressed: () {},
                          child: const Text("Diterima")),
                      SizedBox(
                          width: 20,
                          height: 20), // Mengatur jarak antara tombol
                      ElevatedButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                            overlayColor: MaterialStateProperty.all<Color>(
                                Colors.redAccent),
                          ),
                          onPressed: () {
                            _showTextInputDialog(context);
                          },
                          child: const Text("Ditolak")),
                      SizedBox(
                        width: 50,
                        height: 20,
                      ), // Mengatur jarak dari kanan
                    ],
                  ),
                ]),
          ),
        )));
  }
}

Future<void> _showTextInputDialog(BuildContext context) async {
  TextEditingController _textFieldController = TextEditingController();

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Berikan alasan ditolak'),
        content: TextField(
          controller: _textFieldController,
          decoration: InputDecoration(hintText: "Masukkan Alasan"),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Batal'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('Kirim'),
            onPressed: () {
              String enteredText = _textFieldController.text;
              print('Teks yang dimasukkan: $enteredText');
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}