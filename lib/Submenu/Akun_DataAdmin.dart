import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../APIService.dart';

class AdminData {
  final String name;
  final String email;

  AdminData({required this.name, required this.email});
}

class DataAdminPage extends StatefulWidget {
  @override
  _DataAdminPageState createState() => _DataAdminPageState();
}

class _DataAdminPageState extends State<DataAdminPage> {
 List<AdminData> adminList = [];

  @override
  void initState() {
    super.initState();
    fetchAdminData(); // Menggunakan method baru untuk mengambil data admin
  }

  // Mengubah fetchData menjadi fetchAdminData
  Future<void> fetchAdminData() async {
    try {
      // Menggunakan APIService untuk mengambil data admin
      List<AdminData> data = await APIService().fetchAdminData();
      setState(() {
        adminList = data;
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
          "Data Admin",
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
              itemCount: adminList.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 3,
                  margin:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(
                      adminList[index].name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      adminList[index].email,
                      style: TextStyle(color: Colors.grey[700]),
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


