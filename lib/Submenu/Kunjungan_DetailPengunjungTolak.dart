import 'package:flutter/material.dart';

class Kunjungan_DetailPengunjungTolak extends StatelessWidget {
  final Map<String, dynamic> kunjungan;

  const Kunjungan_DetailPengunjungTolak({Key? key, required this.kunjungan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _nomorAntrianController =
        TextEditingController(text: kunjungan['id_kunjungan'].toString(),);
    TextEditingController _namaController =
        TextEditingController(text: kunjungan['nama_kunjungan']);
    TextEditingController _asalController =
        TextEditingController(text: kunjungan['alamat_kunjungan']);
    TextEditingController _tanggalController =
        TextEditingController(text: kunjungan['tgl_kunjungan']);
    TextEditingController _jenisKunjunganController =
        TextEditingController(text: kunjungan['alasanstatus_kunjungan']);
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
          'Kunjungan Ditolak',
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
                  buildTextField('Alamat', _asalController,),
                  SizedBox(height: 15),
                  buildTextField('Tanggal', _tanggalController),
                  SizedBox(height: 15),
                  
                  SizedBox(height: 15),
                  buildTextField('Nama Instansi', _namaInstansiController),
                  SizedBox(height: 15),
                  buildTextField('Jumlah Orang', _jumlahOrangController),
                  SizedBox(height: 15),
                  buildTextField('No Telepon', _noTeleponController),
                  SizedBox(height: 15),
                  buildTextField(
                      'Tujuan Kunjungan', _tujuanMengunjungiController),
                      SizedBox(height: 20),
                      Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.close_outlined,
                              color: Color.fromRGBO(168, 36, 36, 1),
                              size: 24,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Kunjungan Ditolak',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(168, 36, 36, 1),
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  buildTextField('Alasan Ditolak', _jenisKunjunganController),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: <Widget>[
                  //     Expanded( 
                  //         },
                  //         style: ElevatedButton.styleFrom(
                  //           primary: Color.fromRGBO(168, 36, 36, 1),
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(8),
                  //           ),
                  //         ),
                  //         child: Text(
                  //           'Tolak',
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.bold,
                  //             color: Colors.white,
                  //             fontSize: 20,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(width: 20),
                  //     Expanded(
                  //       child: ElevatedButton(
                  //         onPressed: () async {
                  //           // Lakukan sesuatu ketika tombol 'Diterima' ditekan
                  //         },
                  //         style: ElevatedButton.styleFrom(
                  //           primary: Color(0xFF21690F),
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(8),
                  //           ),
                  //         ),
                  //         child: Text(
                  //           'Terima',
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.bold,
                  //             color: Colors.white,
                  //             fontSize: 20,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
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
              onPressed: () {
                String enteredText = _textFieldController.text;
                print('Teks yang dimasukkan: $enteredText');
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
