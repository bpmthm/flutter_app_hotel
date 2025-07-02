class Kamar {
  final String id, nomor, tipe;
  final int harga;
  final bool tersedia;

  Kamar({required this.id, required this.nomor, required this.tipe, required this.harga, required this.tersedia});

  factory Kamar.fromJson(Map<String, dynamic> json) => Kamar(
    id: json['_id'],
    nomor: json['nomor'],
    tipe: json['tipe'],
    harga: json['harga'],
    tersedia: json['tersedia'],
  );
}
