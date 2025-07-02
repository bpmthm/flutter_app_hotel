import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controllers/kamarController.dart';
import 'detail_kamar_page.dart'; // Pastikan file ini ada di folder pages

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
      labelStyle: TextStyle(color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Kamar')),
      body: FutureBuilder<List<dynamic>>(
        future: _kamarList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final kamar = snapshot.data!;
          if (kamar.isEmpty) {
            return Center(child: Text('Tidak ada kamar tersedia.'));
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
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    leading: Icon(Icons.bed),
                    title: Text('Kamar ${item['nomor']} - ${item['tipe']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Harga: Rp${NumberFormat('#,###').format(item['harga'])}'),
                        _ketersediaanChip(item['tersedia']),
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
