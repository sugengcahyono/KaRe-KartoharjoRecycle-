import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kare/Menu/Beranda.dart';
import 'package:kare/Menu/Kunjungan.dart';
import 'package:kare/Menu/Tabungan.dart';
import 'package:kare/Model/usermodel.dart';
import 'Menu/Akun.dart';

class MyWidget extends StatefulWidget {
  
  final UserModel user;
  const MyWidget({Key? key, required this.user}) : super(key: key);
  
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      BerandaPage(user: widget.user),
      Tabungan(),
      KunjunganScreen(),
      Akun(user: widget.user),
    ];
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: GNav(
          backgroundColor: Colors.white,
          color: Colors.black,
          activeColor: Color(0xFF21690F),
          tabBackgroundColor: Colors.white,
          tabActiveBorder: Border.all(color: Color(0xFF21690F)),
          gap: 5,
          padding: EdgeInsets.all(10),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Beranda',
            ),
            GButton(
              icon: Icons.book,
              text: 'Tabungan',
            ),
            GButton(
              icon: Icons.group,
              text: 'Kunjungan',
            ),
            GButton(
              icon: Icons.person_2,
              text: 'Akun',
            )
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Apakah Anda ingin keluar?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Tidak'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Ya'),
          ),
        ],
      ),
    ).then((value) => value ?? false); // Mengembalikan false jika null
  }
}
