import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class APIService {
  final String baseUrl = "http://192.168.0.103/kare_mobile/KareMobile_API";


//MENAMBAH ADMIN
  Future<Map<String, dynamic>> tambahAdmin2(
  String email,
  String password,
  String namaUser,
  String alamatUser,
  String noTelpUser,
  File? fotoUser, // Gunakan tipe File untuk foto
) async {
  try {
    // Buat request multipart
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/TambahAdmin.php'));
    
    // Tambahkan data biasa
    request.fields['email_user'] = email;
    request.fields['password_user'] = password;
    request.fields['nama_user'] = namaUser;
    request.fields['alamat_user'] = alamatUser;
    request.fields['notelp_user'] = noTelpUser;
    
    // Tambahkan foto jika ada
    if (fotoUser != null) {
      request.files.add(
        http.MultipartFile(
          'foto_user', 
          fotoUser.readAsBytes().asStream(), 
          fotoUser.lengthSync(), 
          filename: fotoUser.path.split('/').last,
        ),
      );
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

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


//MENAMBAH ANGGOTA
  Future<Map<String, dynamic>> tambahAnggota(
    String email,
    String password,
    String namaUser,
    String alamatUser,
    String noTelpUser, {
    String fotoUser = '',

  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/TambahAnggota.php'),
        body: {
          'email_user': email,
          'password_user': password,
          'nama_user': namaUser,
          'alamat_user': alamatUser,
          'notelp_user': noTelpUser,
          'foto_user': fotoUser,

        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        print('Response body: ${response.body}');
        throw Exception(
            'Gagal menambahkan Anggota. Error server: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      throw Exception('Gagal menambahkan Anggota: $e');
    }
  }
  
}
