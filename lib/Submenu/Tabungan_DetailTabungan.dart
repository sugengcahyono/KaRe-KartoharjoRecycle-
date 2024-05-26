import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import package http
import '../APIService.dart';
import 'package:intl/intl.dart';

import 'Tabungan_RiwayatTabungan.dart';

class TabunganDetailPage extends StatefulWidget {
  final int iduser;
  final String namauser;
  final String alamatuser;

  TabunganDetailPage({
    required this.iduser,
    required this.namauser,
    required this.alamatuser,
  });

  @override
  _TabunganDetailPageState createState() => _TabunganDetailPageState();
}

class _TabunganDetailPageState extends State<TabunganDetailPage> {
  List<Map<String, dynamic>> _data = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final apiService = APIService();
      final tabunganData = await apiService.getDataTabungan(
          widget.iduser); // Menggunakan await untuk menunggu hasil Future
      setState(() {
        _data = tabunganData;
        _isLoading = false;
      });
    } catch (e) {
      // Handle error jika gagal mengambil data
      print('Error fetching data: $e');
      setState(() {
        _isLoading = false;
      });
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
            "Detail Tabungan",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.list_alt_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RiwayatTabungan(
                        idUser: widget.iduser), // Sertakan id_user
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.namauser}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${widget.alamatuser}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 500,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: DataTable(
                            columns: [
                              DataColumn(label: Text('Uraian')),
                              DataColumn(label: Text('Tanggal')),
                              DataColumn(label: Text('Type')),
                              DataColumn(label: Text('Nominal')),
                              DataColumn(label: Text('Berat')),
                              DataColumn(label: Text('Saldo')),
                            ],
                            rows: _data.map((item) {
                              return DataRow(
                                cells: [
                                  DataCell(
                                      Text(item['ketsampah_tabungan'] ?? '')),
                                  DataCell(Text(item['tgl_tabungan'] ?? '')),
                                  DataCell(Text(item['tipe_tabungan'] ?? '')),
                                  DataCell(Text(item['hargasampah_tabungan']
                                          ?.toString() ??
                                      '')),
                                  DataCell(Text(item['beratsampah_tabungan']
                                          ?.toString() ??
                                      '')),
                                  DataCell(Text(
                                      item['saldoakhir_tabungan']?.toString() ??
                                          '')),
                                ],
                              );
                            }).toList(),
                          ),
                        )),
                  ),
                  SizedBox(height: 0),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: () async {
                        _showInputDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF21690F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Tambah Transaksi',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void _showTypeDialog(
      BuildContext context, TextEditingController controller) async {
    String? type = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pilih Jenis Transaksi'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Masuk'),
                onTap: () {
                  Navigator.of(context).pop('Masuk');
                },
              ),
              ListTile(
                title: Text('Keluar'),
                onTap: () {
                  Navigator.of(context).pop('Keluar');
                },
              ),
            ],
          ),
        );
      },
    );
    if (type != null) {
      controller.text = type;
    }
  }

  void _showInputDialog(BuildContext context) {
    final uraianController = TextEditingController();
    final typeController = TextEditingController();
    final nominalController = TextEditingController();
    final beratController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Transaksi'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: uraianController,
                  decoration: InputDecoration(labelText: 'Uraian'),
                  maxLines: null,
                  maxLength: 30, // Allow unlimited lines
                ),
                SizedBox(height: 10),
                TextFormField(
                  readOnly: true,
                  onTap: () {
                    _showTypeDialog(context, typeController);
                  },
                  controller: typeController,
                  decoration: InputDecoration(labelText: 'Type'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: nominalController,
                  decoration: InputDecoration(labelText: 'Nominal'),
                  keyboardType:
                      TextInputType.number, // Allow numeric input only
                ),
                SizedBox(height: 10),
                TextField(
                  controller: beratController,
                  decoration: InputDecoration(labelText: 'Berat (kg)'),
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                  ), // Allow numeric input with decimal point
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                _tambahData(
                  uraianController.text,
                  typeController.text.toUpperCase(),
                  double.tryParse(nominalController.text) ?? 0,
                  double.tryParse(beratController.text) ?? 0,
                );
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Tambah'),
            ),
          ],
        );
      },
    );
  }

  void _tambahData(
      String uraian, String type, double nominal, double berat) async {
    try {
      final apiService = APIService();

      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formattedDate = formatter.format(DateTime.now());

      final requestData = {
        'id_user': widget.iduser,
        'tgl_tabungan': formattedDate,
        'ketsampah_tabungan': uraian,
        'beratsampah_tabungan': berat,
        'tipe_tabungan': type.toLowerCase(),
        'hargasampah_tabungan': nominal,
      };

      final responseData = await apiService.tambahTabungan(requestData);

      setState(() {
        var saldo = responseData['saldo_akhir'] as int? ?? 0;
        _data.add({
          'ketsampah_tabungan': uraian,
          'tgl_tabungan': formattedDate,
          'tipe_tabungan': type,
          'hargasampah_tabungan': nominal,
          'beratsampah_tabungan': berat,
          'saldoakhir_tabungan': saldo,
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Transaksi berhasil ditambahkan'),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Gagal menambahkan transaksi: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }
}
