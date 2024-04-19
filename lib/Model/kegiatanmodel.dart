class KegiatanModel {
  final int id_kegiatan;
  final String nama_kegiatan;
  final String deskripsi_kegiatan;
  final String foto_kegiatan;
  final int id_user;

  KegiatanModel({
    required this.id_kegiatan,
    required this.nama_kegiatan,
    required this.deskripsi_kegiatan,
    required this.foto_kegiatan,
    required this.id_user,
  });

  factory KegiatanModel.fromJson(Map<String, dynamic> json) {
    return KegiatanModel(
      id_kegiatan: json['id_kegiatan'],
      nama_kegiatan: json['nama_kegiatan'],
      deskripsi_kegiatan: json['deskripsi_kegiatan'],
      foto_kegiatan: json['foto_kegiatan'],
      id_user: json['id_user'],
    );
  }
}
