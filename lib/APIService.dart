import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:kare/Submenu/Akun_DataAdmin.dart';
import 'package:uuid/uuid.dart';
import 'package:http_parser/http_parser.dart';

import 'Menu/Tabungan.dart';
import 'Model/usermodel.dart';

class APIService {
  // final String baseUrl = "http://172.16.104.122/KaRe_Web/KareMobile_API";
  final String baseUrl1 = "Http://192.168.0.102:8000/api/apimobilekare";  
  
  final String kegiatanUrl = "Http://192.168.0.102:8000/Images/Kegiatan/";  //Alamat foto Kegiatan 
  final String fotoUrl = "Http://192.168.0.102:8000/Images/Foto/";  //Alamat foto User 
  final String produkUrl = "Http://192.168.0.102:8000/Images/Produk/";  //Alamat foto Produk/pupuk 



Future<Map<String, dynamic>> changePassword(int userId, String oldPassword, String newPassword) async {
    final url = Uri.parse('$baseUrl1/changePassword');

    final response = await http.post(
      url,
      body: {
        'id_user': userId.toString(),
        'old_password': oldPassword,
        'new_password': newPassword,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to change password');
    }
  }

  Future<Map<String, dynamic>> deleteAccount(int userId) async {
    final url = Uri.parse('$baseUrl1/deleteAccount');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'id_user': userId}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to delete account: ${response.reasonPhrase}');
    }
  }
  
Future<String> uploadImage(File imageFile) async {
    final url = Uri.parse('$baseUrl1/updatePhoto');

    final response = await http.post(
      url,
      body: {
        'photo': imageFile.path,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['path'];
    } else {
      throw Exception('Failed to upload image');
    }
  }

  Future<void> updateUser({
    required int userId,
    String? nama,
    String? email,
    String? noTelp,
    String? alamat,
    File? fotoUser,
  }) async {
    final url = Uri.parse('$baseUrl1/updateUser');
    var request = http.MultipartRequest('POST', url);

    // Tambahkan data pengguna yang diperbarui ke dalam request
    request.fields['id_user'] = userId.toString();
    if (nama != null) request.fields['nama_user'] = nama;
    if (email != null) request.fields['email_user'] = email;
    if (noTelp != null) request.fields['notelp_user'] = noTelp;
    if (alamat != null) request.fields['alamat_user'] = alamat;
    if (fotoUser != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'foto_user',
          fotoUser.path,
          contentType: MediaType('image', 'jpeg'), // Sesuaikan dengan tipe file gambar
        ),
      );
    }

    // Kirim request
    var response = await request.send();

    if (response.statusCode == 200) {
      print('User data updated successfully');
    } else {
      throw Exception('Failed to update user data');
    }
  }



Future<Map<String, dynamic>> getUserDetail(int userId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl1/getUserDetail'),
        body: {'id_user': userId.toString()}, // Menggunakan POST dengan body berisi id_user
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load user detail');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }



//LOGIN 
Future<UserModel> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl1/login'),
        body: {
          'email_user': email,
          'password_user': password,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          return UserModel.fromJson(responseData['data'], fotoUrl);
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
  var request = http.MultipartRequest('POST', Uri.parse('$baseUrl1/UploadKegiatan'));
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
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl1/TambahAdmin'));
    
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
        Uri.parse('$baseUrl1/TambahAnggota'),
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
      final response = await http.get(Uri.parse('$baseUrl1/get_DataAdmin'));
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

//GET DATA ANGGOTA TABUNGAN 
  Future<List<UserData>> fetchUserData() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl1/get_AnggotaTabungan'));
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


//GET KEGIATAN 
Future<List<Map<String, dynamic>>> getKegiatans() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl1/getKegiatan'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          return List<Map<String, dynamic>>.from(responseData['kegiatans']);
        } else {
          throw Exception(responseData['message']);
        }
      } else {
        throw Exception('Failed to load kegiatans');
      }
    } catch (e) {
      throw Exception('Gagal mendapatkan kegiatans: $e');
    }
  }

  Future<void> updateKegiatan(int idKegiatan, String namaKegiatan, String deskripsiKegiatan, File fotoKegiatan, int idUser) async {
  try {
    final imageUploadRequest = http.MultipartRequest('POST', Uri.parse('$baseUrl1/updateKegiatan'));
    imageUploadRequest.fields['id_kegiatan'] = idKegiatan.toString();
    imageUploadRequest.fields['id_user'] = idUser.toString();

    // Tambahkan data kegiatan yang berubah
    if (namaKegiatan != null && namaKegiatan.isNotEmpty && namaKegiatan != "") {
      imageUploadRequest.fields['nama_kegiatan'] = namaKegiatan;
    }

    if (deskripsiKegiatan != null && deskripsiKegiatan.isNotEmpty && deskripsiKegiatan != "") {
      imageUploadRequest.fields['deskripsi_kegiatan'] = deskripsiKegiatan;
    }

    // Periksa apakah ada gambar baru yang diunggah
    if (fotoKegiatan != null) {
      final fileStream = http.ByteStream(Stream.castFrom(fotoKegiatan.openRead()));
      final length = await fotoKegiatan.length();
      final multipartFile = http.MultipartFile(
        'foto_kegiatan',
        fileStream,
        length,
        filename: fotoKegiatan.path.split('/').last,
      );
      imageUploadRequest.files.add(multipartFile);
    }

    final streamedResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200) {
      throw Exception('Gagal memperbarui kegiatan');
    }
  } catch (e) {
    throw Exception('Gagal memperbarui kegiatan: $e');
  }
}



  Future<Map<String, dynamic>> getDetailKegiatan(int idKegiatan) async {
  try {
    final response = await http.post(Uri.parse('$baseUrl1/getDetailKegiatan?id_kegiatan=$idKegiatan'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Gagal mendapatkan detail kegiatan');
    }
  } catch (e) {
    throw Exception('Gagal mendapatkan detail kegiatan: $e');
  }
}



//DELETE KEGIATAN 
Future<void> deleteKegiatan(int idKegiatan) async {
  final url = Uri.parse('$baseUrl1/DeleteKegiatan');
  final response = await http.post(
    url,
    body: jsonEncode({'id_kegiatan': idKegiatan}),
    headers: {'Content-Type': 'application/json'},
  );
  if (response.statusCode == 200) {
    return;
  } else {
    throw Exception('Failed to delete kegiatan');
  }
}


Future<List<Map<String, dynamic>>> getProduks() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl1/getAllProduk'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          return List<Map<String, dynamic>>.from(responseData['produks']);
        } else {
          throw Exception(responseData['message']);
        }
      } else {
        throw Exception('Failed to load produks');
      }
    } catch (e) {
      throw Exception('Gagal mendapatkan produks: $e');
    }
  }

  Future<void> uploadPupuk(String namaPupuk, String deskripsi, String hargaPupuk, String stokPupuk, File imageFile, int idUser) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl1/UploadProduk'));
    request.fields['nama_produk'] = namaPupuk;
    request.fields['deskripsi_produk'] = deskripsi;
    request.fields['harga_produk'] = hargaPupuk;
    request.fields['stok_produk'] = stokPupuk;
    request.fields['id_user'] = idUser.toString();

    var pic = await http.MultipartFile.fromPath('foto_produk', imageFile.path);
    request.files.add(pic);

    var response = await request.send();

    if (response.statusCode != 200) {
      throw Exception('Gagal mengunggah pupuk');
    }
  }


  Future<Map<String, dynamic>> getDetailPupuk(int idPupuk) async {
  try {
    final response = await http.post(Uri.parse('$baseUrl1/getDetailPupuk?id_produk=$idPupuk'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Gagal mendapatkan detail pupuk');
    }
  } catch (e) {
    throw Exception('Gagal mendapatkan detail pupuk: $e');
  }
}

Future<void> updatePupuk(int idPupuk, String namaPupuk, int hargaPupuk, int stokPupuk, String deskripsiPupuk, File fotoPupuk, int idUser) async {
  try {
    final imageUploadRequest = http.MultipartRequest('POST', Uri.parse('$baseUrl1/updateProduk'));
    imageUploadRequest.fields['id_produk'] = idPupuk.toString();
    imageUploadRequest.fields['id_user'] = idUser.toString();

    // Tambahkan data pupuk yang berubah
    if (namaPupuk != null && namaPupuk.isNotEmpty) {
      imageUploadRequest.fields['nama_produk'] = namaPupuk;
    }

    if (hargaPupuk != null) {
      imageUploadRequest.fields['harga_produk'] = hargaPupuk.toString();
    }

    if (stokPupuk != null) {
      imageUploadRequest.fields['stok_produk'] = stokPupuk.toString();
    }

    if (deskripsiPupuk != null && deskripsiPupuk.isNotEmpty) {
      imageUploadRequest.fields['deskripsi_produk'] = deskripsiPupuk;
    }

    // Periksa apakah ada gambar baru yang diunggah
    if (fotoPupuk != null) {
      final fileStream = http.ByteStream(Stream.castFrom(fotoPupuk.openRead()));
      final length = await fotoPupuk.length();
      final multipartFile = http.MultipartFile(
        'foto_produk',
        fileStream,
        length,
        filename: fotoPupuk.path.split('/').last,
      );
      imageUploadRequest.files.add(multipartFile);
    }

    final streamedResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200) {
      throw Exception('Gagal memperbarui pupuk');
    }
  } catch (e) {
    throw Exception('Gagal memperbarui pupuk: $e');
  }
}

Future<void> deletePupuk(int idPupuk) async {
  final url = Uri.parse('$baseUrl1/DeleteProduk');
  final response = await http.post(
    url,
    body: jsonEncode({'id_produk': idPupuk}),
    headers: {'Content-Type': 'application/json'},
  );
  if (response.statusCode == 200) {
    return;
  } else {
    throw Exception('Failed to delete kegiatan');
  }
}




}


  


  

