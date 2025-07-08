import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controllers/reservasiController.dart';
import 'home_screen.dart'; // tambahin ini kalau mau push ke HomeScreen

class ReservasiFormScreen extends StatefulWidget {
  const ReservasiFormScreen({super.key});

  @override
  _ReservasiFormScreenState createState() => _ReservasiFormScreenState();
}

class _ReservasiFormScreenState extends State<ReservasiFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _jumlahCtrl = TextEditingController();
  DateTime? checkIn, checkOut;
  String? tipeKamar;
  final List<String> tipeKamarList = ['Standard', 'Deluxe', 'Suite'];

  Future<void> _pickDate(bool isCheckIn) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          checkIn = picked;
        } else {
          checkOut = picked;
        }
      });
    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate() &&
        checkIn != null &&
        checkOut != null &&
        tipeKamar != null) {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Konfirmasi'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama: ${_namaCtrl.text}'),
              Text('Email: ${_emailCtrl.text}'),
              Text('Tipe Kamar: $tipeKamar'),
              Text('Jumlah Kamar: ${_jumlahCtrl.text}'),
              Text('Check-in: ${DateFormat.yMMMd().format(checkIn!)}'),
              Text('Check-out: ${DateFormat.yMMMd().format(checkOut!)}'),
              SizedBox(height: 10),
              Text('Apakah data sudah benar?'),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Batal'),
              onPressed: () => Navigator.pop(context, false),
            ),
            ElevatedButton(
              child: Text('Kirim'),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        ),
      );

      if (confirm != true) return;

      final success = await ReservasiController.tambahReservasi({
        'namaTamu': _namaCtrl.text,
        'email': _emailCtrl.text,
        'jumlahKamar': int.parse(_jumlahCtrl.text),
        'tipeKamar': tipeKamar,
        'tanggalCheckIn': checkIn!.toIso8601String(),
        'tanggalCheckOut': checkOut!.toIso8601String(),
      });

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Reservasi berhasil')));
        _formKey.currentState!.reset();
        setState(() {
          checkIn = null;
          checkOut = null;
          tipeKamar = null;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal reservasi')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.teal.shade700,
        title: const Text('Form Reservasi'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          // Kalau mau langsung ke HomeScreen ganti dengan:
          // onPressed: () {
          //   Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(builder: (_) => HomeScreen()),
          //   );
          // },
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Container(
                width: isWide ? 420 : double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.92),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 254, 254, 254),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        'Form Reservasi',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _namaCtrl,
                        decoration: InputDecoration(labelText: 'Nama Tamu'),
                        validator: (val) =>
                            val!.isEmpty ? 'Wajib diisi' : null,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _emailCtrl,
                        decoration: InputDecoration(labelText: 'Email'),
                        validator: (val) =>
                            val!.isEmpty ? 'Wajib diisi' : null,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _jumlahCtrl,
                        decoration: InputDecoration(labelText: 'Jumlah Kamar'),
                        keyboardType: TextInputType.number,
                        validator: (val) =>
                            val!.isEmpty ? 'Wajib diisi' : null,
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: tipeKamar,
                        hint: Text('Pilih Tipe Kamar'),
                        onChanged: (val) async {
                          if (val == null) return;

                          final fasilitas = val == 'Standard'
                              ? [
                                  'Tempat tidur single',
                                  'AC',
                                  'Kamar mandi dalam',
                                  'TV kabel',
                                  'Air mineral',
                                ]
                              : [
                                  'Tempat tidur queen/king',
                                  'AC + Air Purifier',
                                  'Smart TV + Netflix',
                                  'Bathtub + Shower air panas',
                                  'Mini bar',
                                  'Room service 24 jam',
                                  'Balkon pribadi',
                                ];

                          final pilih = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Fasilitas Kamar $val'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (final f in fasilitas)
                                    Text('• $f'),
                                  SizedBox(height: 16),
                                  Text('Pilih kamar tipe ini?',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  child: Text('Batal'),
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                ),
                                ElevatedButton(
                                  child: Text('Pilih'),
                                  onPressed: () =>
                                      Navigator.pop(context, true),
                                ),
                              ],
                            ),
                          );

                          if (pilih == true) {
                            setState(() => tipeKamar = val);
                          } else {
                            setState(() => tipeKamar = null);
                          }
                        },
                        items: tipeKamarList
                            .map((tipe) => DropdownMenuItem(
                                  value: tipe,
                                  child: Text(tipe),
                                ))
                            .toList(),
                        validator: (val) =>
                            val == null ? 'Pilih tipe kamar' : null,
                      ),
                      SizedBox(height: 10),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(checkIn == null
                            ? 'Tanggal Check-in'
                            : 'Check-in: ${DateFormat.yMMMd().format(checkIn!)}'),
                        trailing: Icon(Icons.calendar_today),
                        onTap: () => _pickDate(true),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(checkOut == null
                            ? 'Tanggal Check-out'
                            : 'Check-out: ${DateFormat.yMMMd().format(checkOut!)}'),
                        trailing: Icon(Icons.calendar_today),
                        onTap: () => _pickDate(false),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal.shade700,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: StadiumBorder(),
                          minimumSize: Size(double.infinity, 46),
                        ),
                        onPressed: _submit,
                        child: Text(
                          'Submit Reservasi',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
