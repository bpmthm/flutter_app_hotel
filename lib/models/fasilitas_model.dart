class Fasilitas {
  final String id, nama;
  final String? deskripsi, icon;

  Fasilitas({required this.id, required this.nama, this.deskripsi, this.icon});

  factory Fasilitas.fromJson(Map<String, dynamic> json) => Fasilitas(
    id: json['_id'],
    nama: json['nama'],
    deskripsi: json['deskripsi'],
    icon: json['icon'],
  );
}
