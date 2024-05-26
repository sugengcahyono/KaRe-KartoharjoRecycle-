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
  bool _isLoading = true;
  bool _hasError = false;

  final APIService _apiService = APIService();

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    fetchData(_selectedDate); // Load initial data based on current date
  }

  Future<void> fetchData(DateTime selectedDate) async {
    setState(() {
      _isLoading = true; // Set loading state to true
      _hasError = false; // Reset error state
    });

    // Convert date to the format expected by the API
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    try {
      final data = await _apiService.getTabunganByDate(formattedDate);
      setState(() {
        _beratSampahHari = data ?? [];
      });
    } catch (e) {
      setState(() {
        _hasError = true; // Set error state if an exception occurs
      });
    } finally {
      setState(() {
        _isLoading = false; // Set loading state to false once data is fetched
      });
    }
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
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF21690F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
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
                        _beratSampahHari = null; // Reset data to show loading indicator
                      });
                      await fetchData(pickedDate); // Fetch data based on the selected date
                    }
                  },
                  child: Text(
                    'Pilih Tanggal',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                    width:
                        20), // Add spacing between button and selected date
                Text(
                  DateFormat('dd/MM/yyyy').format(
                      _selectedDate), // Display selected date in dd/MM/yyyy format
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
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
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (_hasError) {
      return Center(child: Text('Error loading data'));
    } else if (_beratSampahHari == null || _beratSampahHari!.isEmpty) {
      return Center(child: Text('Data tidak tersedia'));
    } else {
      return ListView.builder(
        itemCount: _beratSampahHari!.length,
        itemBuilder: (context, index) {
          final item = _beratSampahHari![index];
          final String tipeTabungan = item['tipe_tabungan'];

          // Determine color based on tabungan type
          final Color backgroundColor = (tipeTabungan.toLowerCase() == 'masuk')
              ? Colors.green.shade100
              : Colors.red.shade100;

          return Card(
            color: backgroundColor,
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text('Nama: ${item['nama_user']}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tanggal: ${item['tgl_tabungan']}'),
                  Text('Keterangan Sampah: ${item['ketsampah_tabungan']}'),
                  Text('Berat Sampah: ${item['beratsampah_tabungan']}'),
                  Text('Tipe Tabungan: $tipeTabungan'),
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
