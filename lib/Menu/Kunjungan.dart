import 'package:flutter/material.dart';
import 'package:kare/Submenu/Kunjungan_DetailPengunjung.dart';
import 'package:kare/Submenu/Kunjungan_DetailPengunjungTerima.dart';
import 'package:kare/Submenu/Kunjungan_DetailPengunjungTolak.dart';
import 'package:kare/APIService.dart';

import '../Submenu/Kunjungan_DaftarKunjungan.dart';

class KunjunganScreen extends StatefulWidget {
  const KunjunganScreen({Key? key}) : super(key: key);

  @override
  State<KunjunganScreen> createState() => _KunjunganScreenState();
}

class _KunjunganScreenState extends State<KunjunganScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final APIService _apiService = APIService();
  late Future<List<dynamic>> _kunjunganDiajukan;
  late Future<List<dynamic>> _kunjunganDitolak;
  late Future<List<dynamic>> _kunjunganDiterima;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _kunjunganDiajukan = _apiService.getKunjunganDiajukan();
    _kunjunganDitolak = _apiService.getKunjunganDitolak();
    _kunjunganDiterima = _apiService.getKunjunganDiterima();

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadDataKunjungan() async {
    setState(() {
      _kunjunganDiajukan = _apiService.getKunjunganDiajukan();
      _kunjunganDitolak = _apiService.getKunjunganDitolak();
      _kunjunganDiterima = _apiService.getKunjunganDiterima();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Kunjungan",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        automaticallyImplyLeading: false, 
        actions: [
          IconButton(
            icon: Icon(Icons.list_alt_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RiwayatKunjungan(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 23),
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.blue,
            tabs: const [
              Tab(text: "Permintaan"),
              Tab(text: "Ditolak"),
              Tab(text: "Diterima"),
            ],
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _loadDataKunjungan,
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Tab "Permintaan"
                  FutureBuilder<List<dynamic>>(
                    future: _kunjunganDiajukan,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final kunjungan = snapshot.data![index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Kunjungan_DetailPengunjung(
                                      kunjungan: kunjungan,
                                    ),
                                  ),
                                ).then((value) {
                                  _loadDataKunjungan();
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 25,
                                ),
                                child: Card(color: Colors.green.shade100,
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          kunjungan['nama_kunjungan'],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          kunjungan['alamat_kunjungan'],
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          kunjungan['tgl_kunjungan'],
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(child: Text('No data available'));
                      }
                    },
                  ),
                  // Tab "Ditolak"
                  FutureBuilder<List<dynamic>>(
                    future: _kunjunganDitolak,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final kunjungan = snapshot.data![index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Kunjungan_DetailPengunjungTolak(
                                      kunjungan: kunjungan,
                                    ),
                                  ),
                                ).then((value) {
                                  _loadDataKunjungan();
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 25,
                                ),
                                child: Card(color: Colors.green.shade100,
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          kunjungan['nama_kunjungan'],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          kunjungan['alamat_kunjungan'],
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          kunjungan['tgl_kunjungan'],
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(child: Text('No data available'));
                      }
                    },
                  ),

                  // Tab "Diterima"
                  FutureBuilder<List<dynamic>>(
                    future: _kunjunganDiterima,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final kunjungan = snapshot.data![index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Kunjungan_DetailPengunjungTerima(
                                      kunjungan: kunjungan,
                                    ),
                                  ),
                                ).then((value) {
                                  _loadDataKunjungan();
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 25,
                                ),
                                child: Card(color: Colors.green.shade100,
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          kunjungan['nama_kunjungan'],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          kunjungan['alamat_kunjungan'],
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          kunjungan['tgl_kunjungan'],
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(child: Text('No data available'));
                      }
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
