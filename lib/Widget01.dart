import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kare/Menu/Beranda.dart';
import 'package:kare/Menu/Kunjungan.dart';
import 'package:kare/Menu/Tabungan.dart';
import 'package:kare/Model/usermodel.dart';

import 'APIService.dart';
import 'Menu/Akun.dart';
import 'package:badges/badges.dart' as badges;

class MyWidget extends StatefulWidget {
  final UserModel user;
  const MyWidget({Key? key, required this.user}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late List<Widget> _pages;
  int _selectedIndex = 0;
  Future<int>? _permintaanCountFuture;

  @override
  void initState() {
    super.initState();
    _pages = [
      BerandaPage(user: widget.user),
      Tabungan(),
      KunjunganScreen(),
      Akun(user: widget.user),
    ];
    _loadPermintaanCount();
  }

  Future<void> _loadPermintaanCount() async {
    _permintaanCountFuture = _fetchPermintaanCount();
    setState(() {}); // Trigger a rebuild to update the badge
  }

  Future<int> _fetchPermintaanCount() async {
    try {
      final List<dynamic> kunjunganList = await APIService().getKunjunganDiajukan();
      return kunjunganList.length;
    } catch (e) {
      print('Failed to fetch kunjungan diajukan: $e');
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: FutureBuilder<int>(
          future: _permintaanCountFuture,
          builder: (context, snapshot) {
            int permintaanCount = snapshot.data ?? 0;

            return GNav(
              backgroundColor: Colors.white,
              color: Colors.black,
              activeColor: Color(0xFF21690F),
              tabBackgroundColor: Colors.white,
              tabActiveBorder: Border.all(color: Color(0xFF21690F)),
              gap: 5,
              padding: EdgeInsets.all(10),
              tabs: [
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
                  leading: badges.Badge(
                    badgeContent: Text(
                      '$permintaanCount',
                      style: TextStyle(color: Colors.white),
                    ),
                    showBadge: permintaanCount > 0,
                    child: Icon(Icons.group),
                  ),
                ),
                GButton(
                  icon: Icons.person_2,
                  text: 'Akun',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                  if (index == 2) { // Assuming the "Kunjungan" tab is at index 2
                    _loadPermintaanCount(); // Reload the permintaan count when the "Kunjungan" tab is selected
                  }
                });
              },
            );
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
