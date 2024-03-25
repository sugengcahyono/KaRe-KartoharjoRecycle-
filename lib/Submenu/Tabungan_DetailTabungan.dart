import 'package:flutter/material.dart';
import 'Akun_DataAdmin.dart';

class TabunganDetailPage extends StatefulWidget {
  @override
  _TabunganDetailPageState createState() => _TabunganDetailPageState();
}

class _TabunganDetailPageState extends State<TabunganDetailPage> {
  List<Map<String, dynamic>> _data = [
    {
      'uraian': 'Pembelian Barang',
      'tanggal': '12/03/2024',
      'type': 'D',
      'nominal': 500000,
      'berat': 2,
      'saldo': 1000000
    },
    {
      'uraian': 'Penjualan Barang',
      'tanggal': '13/03/2024',
      'type': 'C',
      'nominal': 800000,
      'berat': 1,
      'saldo': 1800000
    },
    {
      'uraian': 'Penjualan Barang',
      'tanggal': '13/03/2024',
      'type': 'C',
      'nominal': 800000,
      'berat': 1,
      'saldo': 1800000
    },
    {
      'uraian': 'Penjualan Barang',
      'tanggal': '13/03/2024',
      'type': 'C',
      'nominal': 800000,
      'berat': 1,
      'saldo': 1800000
    },
    {
      'uraian': 'ffffffffffffffffffffffffffffffff',
      'tanggal': '15/03/2024',
      'type': 'C',
      'nominal': 800000,
      'berat': 1,
      'saldo': 1800000
    },
    // Add more data as needed
  ];

  TextEditingController uraianController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController nominalController = TextEditingController();
  TextEditingController beratController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                "Detail Tabungan",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                // Tambahkan logika untuk setiap opsi yang dipilih di sini
                print(value);
                if (value == 'Detail Anggota') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DataAdminPage()),
                  );
                }
              },
              itemBuilder: (BuildContext context) {
                return ['Detail Anggota'].map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nama: John Doe',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Alamat: Jalan ABC No. 123',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 300,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Flexible(child: Text('Uraian'))),
                      DataColumn(label: Text('Tanggal')),
                      DataColumn(label: Text('Type')),
                      DataColumn(label: Text('Nominal')),
                      DataColumn(label: Text('Berat')),
                      DataColumn(label: Text('Saldo')),
                    ],
                    rows: _data.map((item) {
                      return DataRow(
                        cells: [
                          DataCell(Flexible(child: Text(item['uraian']))),
                          DataCell(Text(item['tanggal'])),
                          DataCell(Text(item['type'])),
                          DataCell(Text(item['nominal'].toString())),
                          DataCell(Text(item['berat'].toString())),
                          DataCell(Text(item['saldo'].toString())),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: uraianController,
                    decoration: InputDecoration(labelText: 'Uraian'),
                    maxLines: null,
                    maxLength: 30, // Allow unlimited lines
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: typeController,
                    decoration: InputDecoration(labelText: 'Type (C/D)'),
                    maxLength: 1, // Limit input to one character
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
                        decimal:
                            true), // Allow numeric input with decimal point
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _tambahData();
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    },
                    child: Text('Tambah'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _tambahData() {
    // Mendapatkan nilai dari input field
    String uraian = uraianController.text;
    String type =
        typeController.text.toUpperCase(); // Convert input to uppercase
    double nominal = double.tryParse(nominalController.text) ?? 0;
    double berat = double.tryParse(beratController.text) ?? 0;

    // Menambahkan data baru ke _data list
    setState(() {
      _data.add({
        'uraian': uraian,
        'tanggal': DateTime.now().toString(),
        'type': type,
        'nominal': nominal,
        'berat': berat,
        'saldo': 0, // Isi dengan nilai default jika diperlukan
      });

      // Mengosongkan input field setelah data ditambahkan
      uraianController.clear();
      typeController.clear();
      nominalController.clear();
      beratController.clear();
    });
  }
}
