import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class APIService {
  final String baseUrl = "http://192.168.0.103/kare_mobile/KareMobile_API";

  Future<Map<String, dynamic>> TambahAkun(
    String email, String password, String nama_user,
    String alamat_user, String notelp_user) async {
  
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/TambahAdmin.php'),
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'nama_user': nama_user,
        'alamat_user': alamat_user,
        'notelp_user': notelp_user,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } else {
      print('Response body: ${response.body}');
      throw Exception(
          'Registrasi gagal. Error server: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error saat registrasi: $e');
  }
}
}
