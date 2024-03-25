import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kare/Menu/Beranda.dart';
import 'package:kare/Menu/Kunjungan.dart';
import 'package:kare/Menu/Tabungan.dart';

import 'Menu/Akun.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    BerandaPage(), // Contoh halaman Beranda
    Tabungan(), // Contoh halaman Tabungan
    KunjunganScreen(), // Contoh halaman Kunjungan
    Akun(), // Contoh halaman Akun
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Menampilkan halaman yang sesuai dengan indeks terpilih
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
            // Logika navigasi
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          
        ),
      
    );
  }
}
