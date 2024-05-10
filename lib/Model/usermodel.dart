
import '../APIService.dart';

class UserModel {
  final int id;
  final String email;
  final String nama;
  final String alamat;
  final String noTelp;
  final String foto;
  final String level;
  final String message;
  final String otp;

  UserModel({
    required this.id,
    required this.email,
    required this.nama,
    required this.alamat,
    required this.noTelp,
    required this.foto,
    required this.level,
    required this.message,
    required this.otp,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String fotoUrl, String otp) {
    final apiService = APIService(); // Buat instance APIService
    final fotoUrl = apiService.fotoUrl; 
    return UserModel(
      id: json['id_user'] ?? 0,
      email: json['email_user'] ?? '',
      nama: json['nama_user'] ?? '',
      alamat: json['alamat_user'] ?? '',
      noTelp: json['notelp_user'] ?? '',
      foto: fotoUrl + json['foto_user'], // Gabungkan fotoUrl dengan foto_user
      level: json['level_user'] ?? '',
      message: json['message'] ?? '',
         otp: otp,
    );
  }
}
