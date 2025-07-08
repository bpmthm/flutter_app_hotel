import 'dart:convert';
import 'package:http/http.dart' as http;

class FasilitasController {
  static const baseUrl = 'http://192.168.1.11:3000/api/fasilitas';

  static Future<List<dynamic>> getFasilitas() async {
    final res = await http.get(Uri.parse(baseUrl));
    if (res.statusCode == 200) return jsonDecode(res.body)['data'];
    throw Exception('Gagal ambil fasilitas');
  }
}
