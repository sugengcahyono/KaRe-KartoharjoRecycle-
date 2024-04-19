import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:kare/Submenu/Akun_DataAdmin.dart';
import 'package:uuid/uuid.dart';

import 'Menu/Tabungan.dart';
import 'Model/usermodel.dart';

class APIService {
  final String baseUrl = "http://192.168.0.103/kare_mobile/KareMobile_API";


//LOGIN 
Future<UserModel> login(String email, String password) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/Mobile_Login.php'),
      body: {
        'email_user': email,
        'password_user': password,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == 'success') {
        return UserModel.fromJson(responseData['data']);
      } else {
        String errorMessage = responseData['message'];
        // Handle specific error messages
        if (errorMessage.contains('email')) {
          throw Exception('Email tidak ditemukan');
        } else if (errorMessage.contains('password')) {
          throw Exception('Password salah');
        } else if (errorMessage.contains('admin')) {
          throw Exception('Anda bukan admin');
        } else {
          throw Exception(errorMessage);
        }
      }
    } else {
      throw Exception('GagalStatus code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Gagal login: $e');
  }
}

//UPLOAD DATA KEGIATAN
Future<void> uploadKegiatan(String judul, String deskripsi, File imageFile, int idUser) async {
  var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/TambahKegiatan.php'));
  request.fields['nama_kegiatan'] = judul;
  request.fields['deskripsi_kegiatan'] = deskripsi;
  request.fields['id_user'] = idUser.toString(); // Gunakan id_user yang diterima sebagai string

  var pic = await http.MultipartFile.fromPath('foto_kegiatan', imageFile.path);
  request.files.add(pic);

  var response = await request.send();

  if (response.statusCode != 200) {
    throw Exception('Gagal mengunggah kegiatan');
  }
}



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

//AMBIL DATA ADMIN 
  Future<List<AdminData>> fetchAdminData() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/get_DataAdmin.php'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['admins'];
        return data
            .map((item) => AdminData(
                  name: item['nama_user'],
                  email: item['email_user'],
                ))
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<UserData>> fetchUserData() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/get_AnggotaTabungan.php'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['users']; // Ubah 'admins' menjadi 'users'
        return data
            .map((item) => UserData(
                  name: item['nama_user'],
                 
                ))
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
}

//AMBIL DATA KEGIATAN 
Future<List<Map<String, dynamic>>> fetchKegiatanData() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/kegiatan.php'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['status'] == 'success') {
          return List<Map<String, dynamic>>.from(jsonData['kegiatans']);
        } else {
          throw Exception('Failed to fetch kegiatan data: ${jsonData['message']}');
        }
      } else {
        throw Exception('Failed to fetch kegiatan data: status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch kegiatan data: $e');
    }
  }

}

  

