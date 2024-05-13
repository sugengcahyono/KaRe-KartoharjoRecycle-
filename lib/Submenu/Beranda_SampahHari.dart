import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../APIService.dart';

class BeratSampahHari extends StatefulWidget {
  @override
  _BeratSampahHariState createState() => _BeratSampahHariState();
}

class _BeratSampahHariState extends State<BeratSampahHari> {
  late DateTime _selectedDate;
  List<dynamic>? _beratSampahHari;

  final APIService _apiService = APIService();

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    fetchData(_selectedDate); // Memuat data awal berdasarkan tanggal saat ini
  }

  Future<void> fetchData(DateTime selectedDate) async {
    // Mengonversi tanggal ke format yang diharapkan oleh API
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    final data = await _apiService.getTabunganByDate(formattedDate);
    setState(() {
      _beratSampahHari = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Sampah Perhari",
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null && pickedDate != _selectedDate) {
                      setState(() {
                        _selectedDate = pickedDate;
                      });
                      fetchData(pickedDate); // Mengambil data sesuai dengan tanggal yang dipilih
                    }
                  },
                  child: Text('Pilih Tanggal'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: _buildList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    if (_beratSampahHari == null) {
      return Center(child: CircularProgressIndicator());
    } else if (_beratSampahHari!.isEmpty) {
      return Center(child: Text('Data tidak tersedia'));
    } else {
      return ListView.builder(
        itemCount: _beratSampahHari!.length,
        itemBuilder: (context, index) {
          final item = _beratSampahHari![index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text('Nama: ${item['nama_user']}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tanggal: ${item['tgl_tabungan']}'),
                  Text('Keterangan Sampah: ${item['ketsampah_tabungan']}'),
                  Text('Berat Sampah: ${item['beratsampah_tabungan']}'),
                  Text('Tipe Tabungan: ${item['tipe_tabungan']}'),
                  Text('Harga Sampah: ${item['hargasampah_tabungan']}'),
                  Text('Saldo Akhir: ${item['saldoakhir_tabungan']}'),
                ],
              ),
            ),
          );
        },
      );
    }
  }
}
