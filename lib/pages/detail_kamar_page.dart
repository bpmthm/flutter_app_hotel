import 'package:flutter/material.dart';

class DetailKamarPage extends StatelessWidget {
  final Map kamar;

  const DetailKamarPage({required this.kamar, super.key});

    // Fasilitas berdasarkan tipe kamar
  List<Map<String, dynamic>> getFasilitasKamar(String tipe) {
    List<Map<String, dynamic>> fasilitas = [
      {'nama': 'AC', 'icon': Icons.ac_unit},
      {'nama': 'TV Kabel', 'icon': Icons.tv},
      {'nama': 'Wi-Fi', 'icon': Icons.wifi},
      {'nama': 'Shower Air Panas', 'icon': Icons.shower},
      {'nama': 'Tempat Tidur Queen', 'icon': Icons.king_bed},
      {'nama': 'Meja & Kursi Kerja', 'icon': Icons.chair},
    ];

    if (tipe.toLowerCase() == 'deluxe') {
      fasilitas.addAll([
        {'nama': 'Bathtub', 'icon': Icons.bathtub},
        {'nama': 'Balkon Pribadi', 'icon': Icons.balcony},
        {'nama': 'Kulkas Mini', 'icon': Icons.kitchen},
        {'nama': 'Mesin Kopi', 'icon': Icons.coffee_maker},
        {'nama': 'Brankas', 'icon': Icons.lock},
        {'nama': 'Room Service 24 Jam', 'icon': Icons.room_service},
      ]);
    }

    return fasilitas;
  }

  @override
  Widget build(BuildContext context) {
    final tipe = kamar['tipe'] ?? 'Standard';
    final fasilitas = getFasilitasKamar(tipe);

    return Scaffold(
      appBar: AppBar(title: Text('Detail Kamar ${kamar['nomor']}')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (kamar['gambar'] != null && kamar['gambar'].toString().isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  kamar['gambar'],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            SizedBox(height: 12),

            Text(
              tipe,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              'Rp ${kamar['harga']}/malam',
              style: TextStyle(fontSize: 16, color: Colors.green[700]),
            ),
            SizedBox(height: 8),

            Row(
              children: [
                Icon(Icons.people, size: 20),
                SizedBox(width: 4),
                Text('Kapasitas: ${kamar['kapasitas']} orang'),
              ],
            ),
            SizedBox(height: 16),

            Text(
              'Deskripsi:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(kamar['deskripsi'] ?? 'Tidak ada deskripsi kamar.'),
            SizedBox(height: 20),

            Text(
              'Fasilitas Kamar:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: fasilitas.map((f) {
                return Chip(
                  label: Text(f['nama']),
                  avatar: Icon(f['icon'], size: 20),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}