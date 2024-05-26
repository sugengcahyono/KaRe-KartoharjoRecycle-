import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../APIService.dart';

class RiwayatKunjungan extends StatefulWidget {
  final Function(int year, int month)? onFilter;

  RiwayatKunjungan({this.onFilter});

  @override
  _RiwayatKunjunganState createState() => _RiwayatKunjunganState();
}

class _RiwayatKunjunganState extends State<RiwayatKunjungan> {
  late int _selectedYear;
  late int _selectedMonth;
  List<dynamic>? _riwayatKunjungan;

  final APIService _apiService = APIService();

  @override
  void initState() {
    super.initState();
    _selectedYear = DateTime.now().year;
    _selectedMonth = DateTime.now().month;
    fetchData();
  }

  Future<void> fetchData() async {
    final data =
        await _apiService.getRiwayatKunjungan(_selectedMonth, _selectedYear);
    setState(() {
      _riwayatKunjungan = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 60),
        child: Column(
          children: [
            AppBar(
              centerTitle: true,
              backgroundColor: Colors.white,
              title: Text(
                "Riwayat Kunjungan",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<int>(
                  onChanged: (value) {
                    setState(() {
                      _selectedMonth = value!;
                    });
                    widget.onFilter?.call(_selectedYear, _selectedMonth);
                    fetchData();
                  },
                  value: _selectedMonth,
                  items: List.generate(
                    12,
                    (index) => DropdownMenuItem<int>(
                      value: index + 1,
                      child: Text(
                          '${DateFormat.MMMM().format(DateTime(2000, index + 1))}'),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                DropdownButton<int>(
                  
                  onChanged: (value) {
                    setState(() {
                      _selectedYear = value!;
                    });
                    widget.onFilter?.call(_selectedYear, _selectedMonth);
                    fetchData();
                  },
                  value: _selectedYear,
                  items: List.generate(
                    5,
                    (index) => DropdownMenuItem<int>(
                      value: DateTime.now().year - index,
                      child: Text('${DateTime.now().year - index}'),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                        primary: Color(0xFF21690F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                  onPressed: () {
                    fetchData();
                  },
                  child: Text(
                        'OK',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: _riwayatKunjungan != null && _riwayatKunjungan!.isNotEmpty
          ? ListView.builder(
              itemCount: _riwayatKunjungan!.length,
              itemBuilder: (context, index) {
                final kunjungan = _riwayatKunjungan![index];
                final status = kunjungan['status_kunjungan'];
                final cardColor = status == 'diterima'
                    ? Colors.green.shade100
                    : (status == 'ditolak' ? Colors.red.shade100 : Colors.white);

                return Card(
                  color: cardColor,
                  child: ListTile(
                    title: Text(
                      kunjungan['nama_kunjungan'] ?? '',
                      style: TextStyle(
                        fontSize: 18, // Ukuran font
                        fontWeight: FontWeight.bold, // Ketebalan font
                        color: Colors.black, // Warna teks
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Alamat: ${kunjungan['alamat_kunjungan'] ?? ''}'),
                        Text('Tanggal: ${kunjungan['tgl_kunjungan'] ?? ''}'),
                        Text(
                            'Instansi: ${kunjungan['namainstansi_kunjungan'] ?? ''}'),
                        Text('No. HP: ${kunjungan['nohp_kunjungan'] ?? ''}'),
                        Text('Tujuan: ${kunjungan['tujuan_kunjungan'] ?? ''}'),
                        Text('Status: ${kunjungan['status_kunjungan'] ?? ''}'),
                        Text(
                            'Jumlah Orang: ${kunjungan['jumlah_kunjungan'] ?? ''}'),
                        Text(
                            'Alasan : ${kunjungan['alasanstatus_kunjungan'] ?? ''}'),
                      ],
                    ),
                    onTap: () {
                      // Implementasi tindakan ketika item di tap
                    },
                  ),
                );
              },
            )
          : Center(
              child: Text('Tidak ada data'),
            ),
    );
  }
}
