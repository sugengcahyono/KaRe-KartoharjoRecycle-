import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../APIService.dart';
import '../Model/usermodel.dart';
import 'Beranda_DetailKegiatan.dart';
import 'Beranda_TambahKegiatan.dart'; // Impor UserModel

class Berada_Kegiatan extends StatefulWidget {
  final UserModel userModel; // Tambahkan userModel sebagai properti

  const Berada_Kegiatan({Key? key, required this.userModel}) : super(key: key);

  @override
  _Berada_KegiatanState createState() => _Berada_KegiatanState();
}

class _Berada_KegiatanState extends State<Berada_Kegiatan> {
  List<Map<String, dynamic>> kegiatans = [];
  List<Map<String, dynamic>> filteredKegiatans = [];
  APIService apiService = APIService();

  @override
  void initState() {
    super.initState();
    getKegiatans();
  }

  Future<void> getKegiatans() async {
    try {
      final kegiatansData = await apiService.getKegiatans();
      setState(() {
        kegiatans = kegiatansData;
        filteredKegiatans = kegiatansData;
      });
    } catch (e) {
      throw Exception('Gagal mendapatkan kegiatans: $e');
    }
  }

  void searchKegiatan(String query) {
    setState(() {
      filteredKegiatans = kegiatans.where((kegiatan) {
        final title = kegiatan['nama_kegiatan'].toLowerCase();
        return title.contains(query.toLowerCase());
      }).toList();
    });
  }

  Future<void> tambahKegiatan() async {
    // Lakukan proses penambahan kegiatan, misalnya dengan menggunakan HTTP request
    // Setelah proses selesai, panggil kembali fungsi getKegiatans untuk memperbarui tampilan
    try {
      // Lakukan proses penambahan data kegiatan, contoh:
      // final response = await http.post(Uri.parse('${apiService.baseUrl}/tambahKegiatan.php'), body: {'nama_kegiatan': 'Nama Kegiatan', 'deskripsi_kegiatan': 'Deskripsi Kegiatan'});

      // Panggil kembali fungsi getKegiatans untuk memperbarui tampilan
      getKegiatans();
    } catch (e) {
      print('Gagal menambahkan kegiatan: $e');
    }
  }

  void _navigateToDetailKegiatan(int idKegiatan) async {
  try {
    final detailKegiatan = await apiService.getDetailKegiatan(idKegiatan);
    if (detailKegiatan['status'] == 'success') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailKegiatanPage(
            idKegiatan: idKegiatan,
            title: detailKegiatan['data']['nama_kegiatan'],
            deskripsi: detailKegiatan['data']['deskripsi_kegiatan'],
            imageUrl:
                '${apiService.kegiatanUrl}${detailKegiatan['data']['foto_kegiatan']}',
            userModel: widget.userModel,
          ),
        ),
      ).then((value) {
        // Panggil getKegiatans untuk memperbarui tampilan setelah mengedit kegiatan
        getKegiatans();
      });
    } else {
      throw Exception(detailKegiatan['message']); // Throw exception jika gagal mendapatkan kegiatan
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Gagal mendapatkan detail kegiatan: $e'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            "Kegiatan",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.add_a_photo_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        UploadKegiatanPage(userModel: widget.userModel),
                  ),
                ).then((value) {
                  tambahKegiatan();
                });
              },
            ),
          ],
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
                          searchKegiatan(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Cari Kegiatan',
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
                itemCount: filteredKegiatans.length,
                itemBuilder: (context, index) {
                  return _buildKegiatanCard(
                    '${apiService.kegiatanUrl}${filteredKegiatans[index]['foto_kegiatan']}',
                    filteredKegiatans[index]['nama_kegiatan'],
                    filteredKegiatans[index]['id_kegiatan'].toString(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKegiatanCard(String imageUrl, String title, String idKegiatan) {
    return Card(
      margin: EdgeInsets.only(bottom: 20.0),
      child: InkWell(
        onTap: () {
          _navigateToDetailKegiatan(int.parse(idKegiatan));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
