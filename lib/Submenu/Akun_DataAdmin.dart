import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.0.103/kare_mobile/KareMobile_API/get_DataAdmin.php'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['admins'];
        setState(() {
          adminList = data
              .map((item) => AdminData(
                    name: item['nama_user'],
                    email: item['email_user'],
                  ))
              .toList();
        });
      } else {
        print('Failed to load data');
      }
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


