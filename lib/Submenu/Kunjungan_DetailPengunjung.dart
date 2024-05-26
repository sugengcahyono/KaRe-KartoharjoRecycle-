import 'package:flutter/material.dart';
import '../APIService.dart';

class Kunjungan_DetailPengunjung extends StatelessWidget {
  final Map<String, dynamic> kunjungan;
  final APIService apiService = APIService();

  Kunjungan_DetailPengunjung({Key? key, required this.kunjungan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _nomorAntrianController =
        TextEditingController(text: kunjungan['id_kunjungan'].toString());
    TextEditingController _namaController =
        TextEditingController(text: kunjungan['nama_kunjungan']);
    TextEditingController _asalController =
        TextEditingController(text: kunjungan['alamat_kunjungan']);
    TextEditingController _tanggalController =
        TextEditingController(text: kunjungan['tgl_kunjungan']);
    TextEditingController _jenisKunjunganController =
        TextEditingController(text: kunjungan['jenis_kunjungan']);
    TextEditingController _namaInstansiController =
        TextEditingController(text: kunjungan['namainstansi_kunjungan']);
    TextEditingController _jumlahOrangController =
        TextEditingController(text: kunjungan['jumlah_kunjungan'].toString());
    TextEditingController _noTeleponController =
        TextEditingController(text: kunjungan['nohp_kunjungan']);
    TextEditingController _tujuanMengunjungiController =
        TextEditingController(text: kunjungan['tujuan_kunjungan']);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Detail Kunjungan',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 15),
                  buildTextField('Id Kunjungan', _nomorAntrianController),
                  SizedBox(height: 15),
                  buildTextField('Nama', _namaController),
                  SizedBox(height: 15),
                  buildTextField('Alamat', _asalController),
                  SizedBox(height: 15),
                  buildTextField('Tanggal', _tanggalController),
                  SizedBox(height: 15),
                  buildTextField('Nama Instansi', _namaInstansiController),
                  SizedBox(height: 15),
                  buildTextField('Jumlah Orang', _jumlahOrangController),
                  SizedBox(height: 15),
                  buildTextField('No Telepon', _noTeleponController),
                  SizedBox(height: 15),
                  buildTextField(
                      'Tujuan Kunjungan', _tujuanMengunjungiController),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            _showTextInputDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(168, 36, 36, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Tolak',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              await apiService.terimaKunjungan(
                                  kunjungan['id_kunjungan'].toString());
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Kunjungan diterima'), 
                                  backgroundColor: Colors.green,
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Gagal menerima kunjungan'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF21690F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Terima',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 8),
        TextField(
          readOnly: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          maxLines: null, // Mengizinkan baris baru secara otomatis
    textInputAction: TextInputAction.newline,
          controller: controller,
        ),
      ],
    );
  }

  Future<void> _showTextInputDialog(BuildContext context) async {
      TextEditingController _textFieldController = TextEditingController();

      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Berikan alasan ditolak'),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Masukkan Alasan"),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Batal'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text('Kirim'),
                onPressed: () async {
                  try {
                    await apiService.tolakKunjungan(
                        kunjungan['id_kunjungan'].toString(),
                        _textFieldController.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Kunjungan ditolak'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Gagal menolak kunjungan'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
            ],
          );
        },
      );
    }
  }
