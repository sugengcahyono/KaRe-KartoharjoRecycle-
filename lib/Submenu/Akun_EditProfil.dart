import 'package:flutter/material.dart';

class Akun_EditProfil extends StatelessWidget {
  const Akun_EditProfil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Edit Akun",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 30),
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/foto_coba1.jpg'),
                    ),
                    SizedBox(height: 5),
                    TextButton(
                      onPressed: () {
                        // Aksi yang dijalankan ketika teks ditekan
                      },
                      child: Text(
                        'Ubah Foto',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 30),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Nama',
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'No. Handphone',
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Alamat',
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                onPressed: () {
                  // Aksi untuk mengganti password
                },
                style: ElevatedButton.styleFrom(
                primary: Color(0xFF21690F), // Ubah warna tombol menjadi hijau gelap
                shape: RoundedRectangleBorder( // Menyesuaikan bentuk pinggiran tombol
                  borderRadius: BorderRadius.circular(8), // Menyesuaikan tingkat kebulatan pinggiran
                ),),
              child: Text(
                'Simpan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white, fontSize: 20 // Ubah warna teks menjadi putih
                ),
              ), 
            ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
