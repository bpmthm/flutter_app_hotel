import 'package:flutter/material.dart';
import '../controllers/reservasiController.dart';
import 'package:intl/intl.dart';
import '../utils/auth.dart'; // pastikan path ini sesuai

class BookingListScreen extends StatefulWidget {
  final bool isAdmin;
  const BookingListScreen({super.key, this.isAdmin = false});

  @override
  _BookingListScreenState createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
  late Future<List<dynamic>> _reservasiList;

  @override
  void initState() {
    super.initState();
    print("IS ADMIN: ${widget.isAdmin}"); // Untuk debug
    _loadData();
  }

  Future<void> _loadData() async {
    final token = Auth.token;
    setState(() {
      _reservasiList = ReservasiController.getReservasi(token);
    });
  }

  Future<void> _updateStatus(String id, String status) async {
    final token = Auth.token;
    final success = await ReservasiController.updateStatus(id, status, token);
    if (success) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Status diperbarui')));
      _loadData();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Gagal update status')));
    }
  }

  Widget _statusChip(String status) {
    Color color;
    switch (status) {
      case 'pending':
        color = Colors.orange;
        break;
      case 'dipesan':
        color = Colors.green;
        break;
      case 'dibatalkan':
        color = Colors.red;
        break;
      case 'selesai':
        color = Colors.grey;
        break;
      default:
        color = Colors.blueGrey;
    }
    return Chip(
      label: Text(status),
      backgroundColor: color,
      labelStyle: TextStyle(color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text(widget.isAdmin ? 'Admin Booking List' : 'Daftar Reservasi')),
      body: FutureBuilder<List<dynamic>>(
        future: _reservasiList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));

          final data = snapshot.data!;
          if (data.isEmpty) return Center(child: Text('Belum ada reservasi'));

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, i) {
              final item = data[i];
              final checkIn = DateFormat.yMMMd()
                  .format(DateTime.parse(item['tanggalCheckIn']));
              final checkOut = DateFormat.yMMMd()
                  .format(DateTime.parse(item['tanggalCheckOut']));

              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                      '${item['namaTamu']} - ${item['tipeKamar']} (${item['jumlahKamar']} kamar)'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Check-in: $checkIn'),
                      Text('Check-out: $checkOut'),
                      SizedBox(height: 4),
                      _statusChip(item['status']),
                    ],
                  ),
                  trailing: widget.isAdmin
                      ? PopupMenuButton<String>(
                          onSelected: (value) =>
                              _updateStatus(item['_id'], value),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                value: 'dipesan', child: Text('Set Dipesan')),
                            PopupMenuItem(
                                value: 'dibatalkan',
                                child: Text('Set Dibatalkan')),
                          ],
                          icon: Icon(Icons.more_vert),
                        )
                      : null,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
