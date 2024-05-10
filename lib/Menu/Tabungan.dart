import 'package:flutter/material.dart';
import 'package:kare/APIService.dart';
import '../Submenu/Tabungan_DetailTabungan.dart';
import '../Submenu/Tabungan_TambahAnggota.dart';
import '../Widget01.dart';

class UserData {
  final String name;
  final int idUser;

  UserData({required this.name, required this.idUser});
}

class Tabungan extends StatefulWidget {
  @override
  _TabunganState createState() => _TabunganState();
}

class _TabunganState extends State<Tabungan> {
  bool _isObscure = true;
  List<UserData> userList = [];
  List<UserData> filteredUserList = [];
  String searchText = '';

  Future<void> fetchAdminData() async {
    try {
      List<Map<String, dynamic>> data = await APIService().fetchUserData();
      setState(() {
        userList = data
            .map((user) =>
                UserData(name: user['nama_user'], idUser: user['id_user']))
            .toList();
        filteredUserList = userList;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void filterUsers(String query) {
    List<UserData> filteredUsers = userList.where((user) {
      return user.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      filteredUserList = filteredUsers;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAdminData();
  }

  void _navigateToDetailUser(BuildContext context, int idUser) async {
    try {
      final detailUser = await APIService().getUserDetail(idUser);
      if (detailUser['status'] == 'success') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TabunganDetailPage(
              iduser: idUser,
              namauser: detailUser['data']['nama_user'],
              alamatuser: detailUser['data']['alamat_user'],
            ),
          ),
        ).then((value) {
          fetchAdminData();
        });
      } else {
        throw Exception(detailUser['message']);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal mendapatkan detail tabungan: $e'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Menghilangkan tombol kembali
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Tabungan",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
                          setState(() {
                            searchText = value;
                          });
                          filterUsers(value);
                        },
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
                              builder: (context) => Tabungan_TambahAnggota(),
                            ),
                          ).then((value) {
                            fetchAdminData();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: filteredUserList.isEmpty
                  ? Center(
                      child: Text(
                        'Tidak ada anggota yang ditemukan.',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredUserList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            _navigateToDetailUser(
                                context, filteredUserList[index].idUser);
                            print(
                                'User ${filteredUserList[index].name} diklik');
                          },
                          child: Card(
                            color: Colors.green.shade100,
                            child: ListTile(
                              title: Text(
                                filteredUserList[index].name,
                                style: TextStyle(
                                  fontWeight: FontWeight
                                      .bold, // Membuat teks menjadi tebal
                                ),
                              ),
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
