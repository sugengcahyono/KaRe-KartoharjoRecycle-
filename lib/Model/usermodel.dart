class UserModel {
  final int id;
  final String email;
  final String nama;
  final String alamat;
  final String noTelp;
  final String foto;
  final String level;
  final String message; // Add message field

  UserModel({
    required this.id,
    required this.email,
    required this.nama,
    required this.alamat,
    required this.noTelp,
    required this.foto,
    required this.level,
    required this.message, // Initialize message field
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id_user'] ?? 0,
      email: json['email_user'] ?? '',
      nama: json['nama_user'] ?? '',
      alamat: json['alamat_user'] ?? '',
      noTelp: json['notelp_user'] ?? '',
      foto: json['foto_user'] ?? '',
      level: json['level_user'] ?? '',
      message: json['message'] ?? '', // Assign message from JSON
    );
  }
}
