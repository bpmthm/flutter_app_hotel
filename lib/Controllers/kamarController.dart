import 'dart:convert';
import 'package:http/http.dart' as http;

class KamarController {
  static const baseUrl = 'http://192.168.1.12:3000/api/kamar'; // IP laptop


  static Future<List<dynamic>> getKamar() async {
    final res = await http.get(Uri.parse(baseUrl));
    if (res.statusCode == 200) return jsonDecode(res.body)['data'];
    throw Exception('Gagal ambil kamar');
  }
}
