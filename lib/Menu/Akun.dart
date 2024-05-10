import 'package:flutter/material.dart';
import '../APIService.dart';
import '../Login.dart';
import '../Model/usermodel.dart';
import '../Submenu/Akun_DataAdmin.dart';
import '../Submenu/Akun_DataAnggota.dart';
import '../Submenu/Akun_EditProfil.dart';
import '../Submenu/Akun_GantiPassword.dart';
import '../Submenu/Akun_TambahAdmin.dart';

class Akun extends StatelessWidget {
  final UserModel user;

  const Akun({Key? key, required this.user}) : super(key: key);

  void _navigateToDetailUser(BuildContext context, int userId) async {
    try {
      final detailUser = await APIService().getUserDetail(userId);
      if (detailUser['status'] == 'success') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Akun_EditProfil(
              userId: userId,
              email: detailUser['data']['email_user'],
              nama: detailUser['data']['nama_user'],
              noTelp: detailUser['data']['notelp_user'],
              alamat: detailUser['data']['alamat_user'],
              imageUrl:
                  '${APIService().fotoUrl}${detailUser['data']['foto_user']}',
              user: user,
            ),
          ),
        );
      } else {
        throw Exception(detailUser['message']);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal mendapatkan detail pengguna: $e'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Akun",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 30),
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(user.foto),
                    ),
                    SizedBox(height: 20),
                    Text(
                      user.nama,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      user.email,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        _navigateToDetailUser(context, user.id);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green.shade100,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.person, color: Colors.black),
                          SizedBox(width: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Edit Akun',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Akun_GantiPassword(
                              user: user,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green.shade100,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.lock, color: Colors.black),
                          SizedBox(width: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Ubah Password',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DataAdminPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green.shade100,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.account_box, color: Colors.black),
                          SizedBox(width: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Data Admin',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DataAnggotaPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green.shade100,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.groups_2_rounded, color: Colors.black),
                          SizedBox(width: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Data Anggota',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Tambahkan aksi untuk tombol Tambah Admin di sini
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Akun_TambahAkun()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green.shade100,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.group_add,
                              color: Colors.black),
                          SizedBox(width: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Tambah Admin',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Konfirmasi"),
                              content: Text(
                                  "Apakah Anda yakin ingin menghapus akun ini?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: Text(
                                    "Tidak",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    final response = await APIService()
                                        .deleteAccount(user.id);
                                    if (response['success']) {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text("Akun berhasil dihapus."),
                                          duration: Duration(seconds: 3),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                      // Debugging: Print a message to ensure this block is reached
                                      print("Navigating to login page...");
                                      // Direct the user to the login page after deleting the account
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Login(), // Navigate to the login page
                                        ),
                                      ).then((value) {
                                        // Debugging: Print a message after the navigation
                                        print(
                                            "Navigation to login page completed.");
                                      });
                                    } else {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(response['message']),
                                          duration: Duration(seconds: 3),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    "Ya",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green.shade100,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.person_off_sharp, color: Colors.black),
                          SizedBox(width: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Hapus Akun',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
