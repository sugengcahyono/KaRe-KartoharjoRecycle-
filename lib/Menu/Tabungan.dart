import 'package:flutter/material.dart';
import 'package:kare/Lupapassword.dart';

import '../Submenu/Tabungan_DetailTabungan.dart';
import '../Submenu/Tabungan_TambahAnggota.dart';
import '../Widget01.dart';


class Tabungan extends StatefulWidget {
  _TabunganState createState() => _TabunganState();
}

class _TabunganState extends State<Tabungan> {
  bool _isObscure = true; // State variable to toggle password visibility

  List<String> anggotaList = [
    "Anggota 1",
    "Anggota 2",
    "Anggota 3s",
    "Anggota 4",
    "Anggota 5",
    "Anggota 6",
    "Anggota 7",
    "Anggota 8",
    "Anggota 9",
    "Anggota 10",
    "Anggota 11",
    "Anggota 12",
  ]; // Contoh daftar anggota yang sudah terdaftar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(kToolbarHeight), // Menyesuaikan tinggi AppBar
        child: AppBar(
          automaticallyImplyLeading: false, // Menghilangkan tombol kembali
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            "Tabungan",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
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
                          hintText: 'Cari Nama',
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(color: Colors.black),
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.person_add),
                        color: Color(0xFF21690F),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Tabungan_TambahAnggota()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                itemCount: anggotaList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TabunganDetailPage()),
                          );
                      // Ketika nama anggota diklik
                      // Lakukan aksi sesuai kebutuhan, misalnya tampilkan detail anggota atau lakukan tindakan lainnya
                      print('Anggota ${index + 1} diklik');
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(anggotaList[index]),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
