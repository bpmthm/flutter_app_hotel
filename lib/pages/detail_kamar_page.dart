import 'package:flutter/material.dart';

class DetailKamarPage extends StatelessWidget {
  final Map kamar;

  const DetailKamarPage({required this.kamar, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Kamar ${kamar['nomor']}')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(kamar['gambar'], height: 200, width: double.infinity, fit: BoxFit.cover),
            SizedBox(height: 12),
            Text(kamar['tipe'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Rp ${kamar['harga']}/malam'),
            SizedBox(height: 8),
            Text('Kapasitas: ${kamar['kapasitas']} orang'),
            SizedBox(height: 8),
            Text(kamar['deskripsi'] ?? 'Tidak ada deskripsi'),
          ],
        ),
      ),
    );
  }
}
