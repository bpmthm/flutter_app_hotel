import 'package:flutter/material.dart';

class FasilitasFormScreen extends StatefulWidget {
  const FasilitasFormScreen({super.key});

  @override
  State<FasilitasFormScreen> createState() => _FasilitasFormScreenState();
}

class _FasilitasFormScreenState extends State<FasilitasFormScreen> {
  final List<Map<String, dynamic>> fasilitas = [
    {
      'nama': 'Kolam Renang',
      'icon': Icons.pool,
      'deskripsi': 'Kolam renang outdoor untuk dewasa dan anak-anak.',
    },
    {
      'nama': 'Wi-Fi Gratis',
      'icon': Icons.wifi,
      'deskripsi': 'Internet gratis tersedia di seluruh area hotel.',
    },
    {
      'nama': 'Gym / Fitness Center',
      'icon': Icons.fitness_center,
      'deskripsi': 'Peralatan olahraga lengkap dan modern.',
    },
    {
      'nama': 'Restoran',
      'icon': Icons.restaurant,
      'deskripsi': 'Menu lokal & internasional tersedia setiap hari.',
    },
    {
      'nama': 'Parkir Gratis',
      'icon': Icons.local_parking,
      'deskripsi': 'Area parkir luas dan aman tanpa biaya tambahan.',
    },
    {
      'nama': 'Spa & Sauna',
      'icon': Icons.spa,
      'deskripsi': 'Layanan pijat, sauna, dan relaksasi premium.',
    },
    {
      'nama': 'Layanan Kamar 24 Jam',
      'icon': Icons.room_service,
      'deskripsi': 'Layanan pesan makanan/minuman langsung ke kamar.',
    },
    {
      'nama': 'Antar Jemput Bandara',
      'icon': Icons.airport_shuttle,
      'deskripsi': 'Layanan shuttle hotel ke bandara PP.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fasilitas Hotel')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: fasilitas.length,
        itemBuilder: (context, index) {
          final item = fasilitas[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Icon(item['icon'], size: 40, color: Colors.blue),
              title: Text(item['nama'], style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(item['deskripsi']),
            ),
          );
        },
      ),
    );
  }
}