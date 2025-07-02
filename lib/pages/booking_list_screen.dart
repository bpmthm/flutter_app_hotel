import 'package:flutter/material.dart';
import '../controllers/reservasiController.dart';
import 'package:intl/intl.dart';

class BookingListScreen extends StatefulWidget {
  const BookingListScreen({super.key});

  @override
  _BookingListScreenState createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
  late Future<List<dynamic>> _reservasiList;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _reservasiList = ReservasiController.getReservasi();
  }

  Future<void> _updateStatus(String id, String status) async {
    final success = await ReservasiController.updateStatus(id, status);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Status diperbarui')));
      setState(() => _loadData());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal update status')));
    }
  }

  Widget _statusChip(String status) {
    return Chip(
      label: Text(status),
      backgroundColor: status == 'dipesan' ? Colors.green : Colors.red,
      labelStyle: TextStyle(color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Booking')),
      body: FutureBuilder<List<dynamic>>(
        future: _reservasiList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
          if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));

          final data = snapshot.data!;
          if (data.isEmpty) return Center(child: Text('Belum ada reservasi'));

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, i) {
              final item = data[i];
              final checkIn = DateFormat.yMMMd().format(DateTime.parse(item['tanggalCheckIn']));
              final checkOut = DateFormat.yMMMd().format(DateTime.parse(item['tanggalCheckOut']));

              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text('${item['namaTamu']} - ${item['tipeKamar']} (${item['jumlahKamar']} kamar)'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Check-in: $checkIn'),
                      Text('Check-out: $checkOut'),
                      SizedBox(height: 4),
                      _statusChip(item['status']),
                    ],
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) => _updateStatus(item['_id'], value),
                    itemBuilder: (context) => [
                      PopupMenuItem(value: 'dipesan', child: Text('Set Dipesan')),
                      PopupMenuItem(value: 'dibatalkan', child: Text('Set Dibatalkan')),
                    ],
                    icon: Icon(Icons.more_vert),
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
