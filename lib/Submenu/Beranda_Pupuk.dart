import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../APIService.dart';
import '../Model/usermodel.dart';
import 'Beranda_DetailPupuk.dart';
import 'Beranda_TambahPupuk.dart'; // Tambahkan import untuk halaman upload pupuk

class BeradaPupuk extends StatefulWidget {
  final UserModel userModel;
  
  const BeradaPupuk({Key? key, required this.userModel}) : super(key: key);

  @override
  _BeradaPupukState createState() => _BeradaPupukState();
}

class _BeradaPupukState extends State<BeradaPupuk> {
  List<Map<String, dynamic>> produks = [];
  List<Map<String, dynamic>> filteredProduks = [];
  APIService apiService = APIService();

  @override
  void initState() {
    super.initState();
    getProduks();
  }

  Future<void> getProduks() async {
    try {
      final produksData = await apiService.getProduks();
      setState(() {
        produks = produksData;
        filteredProduks = produksData;
      });
    } catch (e) {
      print('Gagal mendapatkan produks: $e');
    }
  }

  void searchProduk(String query) {
    setState(() {
      filteredProduks = produks.where((produk) {
        final title = produk['nama_produk'].toLowerCase();
        return title.contains(query.toLowerCase());
      }).toList();
    });
  }

  Future<void> tambahPupuk() async {
    // Lakukan proses penambahan kegiatan, misalnya dengan menggunakan HTTP request
    // Setelah proses selesai, panggil kembali fungsi getKegiatans untuk memperbarui tampilan
    try {
      // Lakukan proses penambahan data kegiatan, contoh:
      // final response = await http.post(Uri.parse('${apiService.baseUrl}/tambahKegiatan.php'), body: {'nama_kegiatan': 'Nama Kegiatan', 'deskripsi_kegiatan': 'Deskripsi Kegiatan'});

      // Panggil kembali fungsi getKegiatans untuk memperbarui tampilan
      getProduks();
    } catch (e) {
      print('Gagal menambahkan kegiatan: $e');
    }
  }

  void _navigateToDetailPupuk(int idPupuk) async {
  try {
    final detailPupuk = await apiService.getDetailPupuk(idPupuk);
    if (detailPupuk['status'] == 'success') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailPupukPage(
            idPupuk: idPupuk,
            title: detailPupuk['data']['nama_produk'],
            harga: int.parse(detailPupuk['data']['harga_produk']), // Konversi dari String ke int
            stok: int.parse(detailPupuk['data']['stok_produk']), // Konversi dari String ke int
            deskripsi: detailPupuk['data']['deskripsi_produk'],
            imageUrl: '${apiService.produkUrl}${detailPupuk['data']['foto_produk']}',
            userModel: widget.userModel,
          ),
        ),
      ).then((value) {
        // Panggil getKegiatans untuk memperbarui tampilan setelah mengedit kegiatan
        getProduks();
      });
    } else {
      throw Exception(detailPupuk['message']); // Throw exception jika gagal mendapatkan kegiatan
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Gagal mendapatkan detail pupuk: $e'),
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
            "Pupuk",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.assignment_add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        UploadPupukPage(userModel: widget.userModel), // Gunakan BerandaTambahPupukPage
                  ),
                ).then((value) {
                  tambahPupuk();
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
                          searchProduk(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Cari Pupuk',
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
                itemCount: filteredProduks.length,
                itemBuilder: (context, index) {
                  return _buildProdukCard(
                    '${apiService.produkUrl}${filteredProduks[index]['foto_produk']}',
                    filteredProduks[index]['nama_produk'],
                    filteredProduks[index]['id_produk'].toString(), // Gunakan id_produk
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProdukCard( String image, String title, String idproduk) {
    return Card(
      margin: EdgeInsets.only(bottom: 20.0),
      child: InkWell(
        onTap: () {
          _navigateToDetailPupuk(int.parse(idproduk));
          // Implementasi aksi ketika card ditekan di sini
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
                    image: NetworkImage(image),
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
