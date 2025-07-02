import 'package:flutter/material.dart';
import '../controllers/fasilitasController.dart';

class FasilitasListScreen extends StatefulWidget {
  const FasilitasListScreen({super.key});

  @override
  _FasilitasListScreenState createState() => _FasilitasListScreenState();
}

class _FasilitasListScreenState extends State<FasilitasListScreen> {
  late Future<List<dynamic>> _fasilitasList;

  @override
  void initState() {
    super.initState();
    _fasilitasList = FasilitasController.getFasilitas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fasilitas Hotel')),
      body: FutureBuilder<List<dynamic>>(
        future: _fasilitasList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
          if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));

          final fasilitas = snapshot.data!;
          if (fasilitas.isEmpty) return Center(child: Text('Tidak ada fasilitas.'));

          return ListView.builder(
            itemCount: fasilitas.length,
            itemBuilder: (context, i) {
              final item = fasilitas[i];
              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  leading: Icon(Icons.hotel),
                  title: Text(item['nama']),
                  subtitle: Text(item['deskripsi'] ?? '-'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
