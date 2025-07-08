import 'dart:convert';
import 'package:http/http.dart' as http;

class ReservasiController {
  static const baseUrl = 'http://192.168.1.11:3000/api/reservasi';

  static Future<bool> tambahReservasi(Map<String, dynamic> data) async {
    final res = await http.post(
      Uri.parse(baseUrl),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    return res.statusCode == 201;
  }

  static Future<List<dynamic>> getReservasi(String? token) async {
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    final res = await http.get(Uri.parse(baseUrl), headers: headers);
    if (res.statusCode == 200) return jsonDecode(res.body)['data'];
    throw Exception('Gagal ambil reservasi');
  }

  static Future<bool> updateStatus(
      String id, String status, String? token) async {
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    final res = await http.patch(
      Uri.parse('$baseUrl/$id'),
      body: jsonEncode({'status': status}),
      headers: headers,
    );
    return res.statusCode == 200;
  }
}
