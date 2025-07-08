import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controllers/kamarController.dart';
import 'detail_kamar_page.dart';

class KamarListScreen extends StatefulWidget {
  const KamarListScreen({super.key});

  @override
  _KamarListScreenState createState() => _KamarListScreenState();
}

class _KamarListScreenState extends State<KamarListScreen> {
  late Future<List<dynamic>> _kamarList;

  @override
  void initState() {
    super.initState();
    _kamarList = KamarController.getKamar();
  }

  Widget _ketersediaanChip(bool tersedia) {
    return Chip(
      label: Text(tersedia ? 'Tersedia' : 'Tidak Tersedia'),
      backgroundColor: tersedia ? Colors.green : Colors.grey,
      labelStyle: const TextStyle(color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Kamar')),
      body: FutureBuilder<List<dynamic>>(
        future: _kamarList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final kamar = snapshot.data!;
          if (kamar.isEmpty) {
            return const Center(child: Text('Tidak ada kamar tersedia.'));
          }

          return ListView.builder(
            itemCount: kamar.length,
            itemBuilder: (context, i) {
              final item = kamar[i];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailKamarPage(kamar: item),
                    ),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: const Icon(Icons.bed),
                    title: Text('Kamar ${item['nomor'] ?? '-'} - ${item['tipe'] ?? '-'}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Harga: Rp${NumberFormat('#,###').format(item['harga'] ?? 0)}'),
                        _ketersediaanChip(item['tersedia'] ?? false),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
