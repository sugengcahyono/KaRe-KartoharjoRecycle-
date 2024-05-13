import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../APIService.dart';

class DataAnggota {
  final int id;
  final String name;
  final String email;
  final String alamat;

  DataAnggota({required this.id, required this.name, required this.email, required this.alamat});
}

class DataAnggotaPage extends StatefulWidget {
  @override
  _DataAnggotaPageState createState() => _DataAnggotaPageState();
}

class _DataAnggotaPageState extends State<DataAnggotaPage> {
  List<DataAnggota> userList = [];
  List<DataAnggota> filteredUserList = [];

  @override
  void initState() {
    super.initState();
    fetchAnggotaData(); // Menggunakan method untuk mengambil data user
  }

  Future<void> fetchAnggotaData() async {
    try {
      // Menggunakan APIService untuk mengambil data user
      List<DataAnggota> data = await APIService().fetchAnggotaData();
      setState(() {
        userList = data;
        filteredUserList = userList; // Awalnya, tampilkan seluruh data
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> deleteAnggota(int id) async {
    try {
      await APIService().deleteAccount(id);
      // Jika penghapusan berhasil, perbarui tampilan dengan mengambil ulang data anggota
      fetchAnggotaData();
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _showConfirmationDialog(int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Apakah Anda yakin ingin menghapus anggota ini?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Hapus'),
              onPressed: () {
                // Hapus anggota jika pengguna menekan tombol Hapus
                deleteAnggota(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void searchUser(String query) {
    setState(() {
      filteredUserList = userList.where((user) =>
        user.name.toLowerCase().contains(query.toLowerCase())
      ).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Data Anggota",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
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
                        onChanged: (value) {
                          searchUser(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Cari Anggota',
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
              child: ListView.builder(
                itemCount: filteredUserList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: Text(
                        filteredUserList[index].name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            filteredUserList[index].email,
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          Text(
                            filteredUserList[index].alamat,
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // Ketika ikon hapus diklik, tampilkan dialog konfirmasi
                          _showConfirmationDialog(filteredUserList[index].id);
                        },
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
