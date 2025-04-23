import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = 'https://seu-id.mockapi.io/api/v1/users';

  // vo tenta aqui enviar os arq (POST)
  Future<void> postData(Map<String, String> data) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception('Falha ao enviar dados: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Erro na requisição: $e');
    }
  }

  // Busca os dado mocado la do MockAPI (GET)
  Future<List<Map<String, dynamic>>> getData() async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Falha ao buscar dados: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Erro na requisição: $e');
    }
  }
}