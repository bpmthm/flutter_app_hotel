import 'package:flutter/material.dart';
import 'kamar_list_screen.dart';
import 'fasilitas_form_screen.dart';
import 'reservasi_form_screen.dart';
import 'booking_list_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<_MenuItem> menuItems = [
    _MenuItem('Daftar Kamar', Icons.bed, KamarListScreen()),
    _MenuItem('Fasilitas Hotel', Icons.pool, FasilitasListScreen()),
    _MenuItem('Reservasi Kamar', Icons.add_business, ReservasiFormScreen()),
    _MenuItem('Manajemen Booking', Icons.list_alt, BookingListScreen()),
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manajemen Hotel')),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return Card(
            child: ListTile(
              leading: Icon(item.icon, size: 30),
              title: Text(item.title, style: TextStyle(fontSize: 18)),
              trailing: Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => item.page),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MenuItem {
  final String title;
  final IconData icon;
  final Widget page;
  _MenuItem(this.title, this.icon, this.page);
}
