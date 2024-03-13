import 'package:flutter/material.dart';

class TabunganDetailPage extends StatefulWidget {
  @override
  _TabunganDetailPageState createState() => _TabunganDetailPageState();
}

class _TabunganDetailPageState extends State<TabunganDetailPage> {
  List<Map<String, dynamic>> _data = [
    {'uraian': 'Pembelian Barang', 'tanggal': '12/03/2024', 'type': 'D', 'nominal': 500000, 'berat': 2, 'saldo': 1000000},
    {'uraian': 'Penjualan Barang', 'tanggal': '13/03/2024', 'type': 'C', 'nominal': 800000, 'berat': 1, 'saldo': 1800000},
    // Add more data as needed
  ];

  TextEditingController uraianController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController nominalController = TextEditingController();
  TextEditingController beratController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Tabungan'),
      ),
      body: Column(
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
          Expanded(
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
                      DataCell(Text(item['uraian'])),
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
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: uraianController,
                  decoration: InputDecoration(labelText: 'Uraian'),
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
                  keyboardType: TextInputType.number, // Allow numeric input only
                ),
                SizedBox(height: 10),
                TextField(
                  controller: beratController,
                  decoration: InputDecoration(labelText: 'Berat (kg)'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true), // Allow numeric input with decimal point
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _tambahData();
                  },
                  child: Text('Tambah'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _tambahData() {
    // Mendapatkan nilai dari input field
    String uraian = uraianController.text;
    String type = typeController.text.toUpperCase(); // Convert input to uppercase
    double nominal = double.tryParse(nominalController.text) ?? 0;
    double berat = double.tryParse(beratController.text) ?? 0;

    // Menambahkan data baru ke _data list
    setState(() {
      _data.insert(0, {
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

void main() {
  runApp(MaterialApp(
    home: TabunganDetailPage(),
  ));
}
