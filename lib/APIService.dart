import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class APIService {
  final String baseUrl = "http://172.16.106.2/kare_mobile/KareMobile_API";

  Future<Map<String, dynamic>> tambahAdmin2(
      String email,
      String password,
      String namaUser,
      String alamatUser,
      String noTelpUser,
      {String? fotoUser,
      String? kodeOTP}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/TambahAdmin.php'),
        body: {
          'email_user': email,
          'password_user': password,
          'nama_user': namaUser,
          'alamat_user': alamatUser,
          'notelp_user': noTelpUser,
          'foto_user': fotoUser ?? '', 
          'kodeotp_user': kodeOTP ?? '',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        print('Response body: ${response.body}');
        throw Exception(
            'Gagal menambahkan admin. Error server: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      throw Exception('Gagal menambahkan admin: $e');
    }
  }
}

void main(List<String> args) async {
  try {
    final response = await APIService().tambahAdmin2(
      'admin@example.com',
      'password',
      'Admin Baru',
      'Jl. Contoh No. 123',
      '081234567890',
      fotoUser: 'url_foto.jpg', // Opsional
      kodeOTP: '123456', // Opsional
    );

    print(response); // Cetak respons dari server
  } catch (e) {
    print('Terjadi kesalahan: $e');
  }
}
