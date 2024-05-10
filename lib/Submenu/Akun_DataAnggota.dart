import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../APIService.dart';

class DataAnggota {
  final String name;
  final String email;
  final String alamat;

  DataAnggota({required this.name, required this.email, required this.alamat});
}

class DataAnggotaPage extends StatefulWidget {
  @override
  _DataUserPageState createState() => _DataUserPageState();
}

class _DataUserPageState extends State<DataAnggotaPage> {
  List<DataAnggota> userList = [];

  @override
  void initState() {
    super.initState();
    fetchAnggotaData(); // Menggunakan method untuk mengambil data user
  }

  // Mengubah pemanggilan fetchAdminData menjadi fetchUserData
  Future<void> fetchAnggotaData() async {
    try {
      // Menggunakan APIService untuk mengambil data user
      List<DataAnggota> data = await APIService().fetchAnggotaData();
      setState(() {
        userList = data;
      });
    } catch (e) {
      print('Error: $e');
    }
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
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            ListView.builder(
              itemCount: userList.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 3,
                  margin:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(
                      userList[index].name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userList[index].email,
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        Text(
                          userList[index].alamat,
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
