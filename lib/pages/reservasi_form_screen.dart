import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controllers/reservasiController.dart';

class ReservasiFormScreen extends StatefulWidget {
  const ReservasiFormScreen({super.key});

  @override
  _ReservasiFormScreenState createState() => _ReservasiFormScreenState();
}

class _ReservasiFormScreenState extends State<ReservasiFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _jumlahCtrl = TextEditingController();
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
          SnackBar(content: Text('Reservasi berhasil'))
        );
        _formKey.currentState!.reset();
        setState(() {
          checkIn = null;
          checkOut = null;
          tipeKamar = null;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal reservasi'))
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Reservasi')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(children: [
            TextFormField(
              controller: _namaCtrl,
              decoration: InputDecoration(labelText: 'Nama Tamu'),
              validator: (val) => val!.isEmpty ? 'Wajib diisi' : null,
            ),
            TextFormField(
              controller: _emailCtrl,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (val) => val!.isEmpty ? 'Wajib diisi' : null,
            ),
            TextFormField(
              controller: _jumlahCtrl,
              decoration: InputDecoration(labelText: 'Jumlah Kamar'),
              keyboardType: TextInputType.number,
              validator: (val) => val!.isEmpty ? 'Wajib diisi' : null,
            ),
            DropdownButtonFormField<String>(
              value: tipeKamar,
              hint: Text('Pilih Tipe Kamar'),
              onChanged: (val) => setState(() => tipeKamar = val),
              items: tipeKamarList.map((tipe) => DropdownMenuItem(
                value: tipe,
                child: Text(tipe),
              )).toList(),
              validator: (val) => val == null ? 'Pilih tipe kamar' : null,
            ),
            ListTile(
              title: Text(checkIn == null
                  ? 'Tanggal Check-in'
                  : 'Check-in: ${DateFormat.yMMMd().format(checkIn!)}'),
              trailing: Icon(Icons.calendar_today),
              onTap: () => _pickDate(true),
            ),
            ListTile(
              title: Text(checkOut == null
                  ? 'Tanggal Check-out'
                  : 'Check-out: ${DateFormat.yMMMd().format(checkOut!)}'),
              trailing: Icon(Icons.calendar_today),
              onTap: () => _pickDate(false),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Submit Reservasi'),
            ),
          ]),
        ),
      ),
    );
  }
}
