class Reservasi {
  final String id, namaTamu, email, tipeKamar, status;
  final int jumlahKamar;
  final DateTime checkIn, checkOut;

  Reservasi({
    required this.id,
    required this.namaTamu,
    required this.email,
    required this.tipeKamar,
    required this.jumlahKamar,
    required this.checkIn,
    required this.checkOut,
    required this.status,
  });

  factory Reservasi.fromJson(Map<String, dynamic> json) => Reservasi(
    id: json['_id'],
    namaTamu: json['namaTamu'],
    email: json['email'],
    tipeKamar: json['tipeKamar'],
    jumlahKamar: json['jumlahKamar'],
    checkIn: DateTime.parse(json['tanggalCheckIn']),
    checkOut: DateTime.parse(json['tanggalCheckOut']),
    status: json['status'],
  );
}
