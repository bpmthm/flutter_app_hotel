import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../utils/auth.dart';
import 'booking_list_screen.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final url = Uri.parse('http://192.168.1.11:3000/api/admin/login');
    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': _emailCtrl.text,
        'password': _passwordCtrl.text,
      }),
    );

    setState(() => _isLoading = false);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);

      // simpan token
      Auth.setToken(data['token']);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login berhasil')),
      );

      // arahkan ke halaman booking admin
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const BookingListScreen(isAdmin: true),
        ),
      );
    } else {
      final msg = jsonDecode(res.body)['message'] ?? 'Login gagal';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(children: [
            TextFormField(
              controller: _emailCtrl,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (val) => val!.isEmpty ? 'Email wajib diisi' : null,
            ),
            TextFormField(
              controller: _passwordCtrl,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (val) => val!.isEmpty ? 'Password wajib diisi' : null,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading ? null : _login,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Login'),
            ),
          ]),
        ),
      ),
    );
  }
}
