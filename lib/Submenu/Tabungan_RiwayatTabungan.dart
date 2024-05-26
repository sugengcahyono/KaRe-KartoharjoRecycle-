import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../APIService.dart';

class RiwayatTabungan extends StatefulWidget {
  final Function(int year, int month)? onFilter;
  final int idUser;

  RiwayatTabungan({this.onFilter, required this.idUser});

  @override
  _RiwayatTabunganState createState() => _RiwayatTabunganState();
}

class _RiwayatTabunganState extends State<RiwayatTabungan> {
  late int _selectedYear;
  late int _selectedMonth;
  List<dynamic>? _riwayatTabungan; // Update the initialization

  final APIService _apiService = APIService();

  @override
  void initState() {
    super.initState();
    _selectedYear = DateTime.now().year;
    _selectedMonth = DateTime.now().month;
    fetchData();
  }

  Future<void> fetchData() async {
    final data = await _apiService.getRiwayatTabungan(
        widget.idUser, _selectedMonth, _selectedYear);
    setState(() {
      _riwayatTabungan = data;
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
                "Riwayat Tabungan",
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
                  onPressed: () {
                    fetchData();
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        height: 650,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                columnSpacing: 8, // Atur jarak antar kolom
                horizontalMargin: 12, // Atur batas horizontal
                columns: [
                  DataColumn(label: Text('Uraian')),
                  DataColumn(label: Text('Tanggal')),
                  DataColumn(label: Text('Type')),
                  DataColumn(label: Text('Nominal')),
                  DataColumn(label: Text('Berat')),
                  DataColumn(label: Text('Saldo')),
                ],
                rows: _riwayatTabungan != null && _riwayatTabungan!.isNotEmpty
                    ? _riwayatTabungan!.map((item) {
                        return DataRow(
                          cells: [
                            DataCell(Text(item['ketsampah_tabungan'] ?? '')),
                            DataCell(Text(item['tgl_tabungan'] ?? '')),
                            DataCell(Text(item['tipe_tabungan'] ?? '')),
                            DataCell(Text(
                                item['hargasampah_tabungan']?.toString() ??
                                    '')),
                            DataCell(Text(
                                item['beratsampah_tabungan']?.toString() ??
                                    '')),
                            DataCell(Text(
                                item['saldoakhir_tabungan']?.toString() ?? '')),
                          ],
                        );
                      }).toList()
                    : [
                        // Placeholder row if _riwayatTabungan is null or empty
                        DataRow(cells: [
                          DataCell(Text('No data available',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                        ]),
                      ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
