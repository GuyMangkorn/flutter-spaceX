import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class BaseClient {
  final client = Client();
  final baseUrl = dotenv.get('BASE_URL', fallback: '');

  Future<Response> get(String api, {Map<String, String>? headers}) async {
    final uri = Uri.parse(baseUrl + api);
    final response = await client.get(uri, headers: headers);
    return response;
  }

  Future<Response> post(String api, {dynamic payload}) async {
    final uri = Uri.parse(baseUrl + api);
    final parsePayload = json.decode(payload);
    final response = await client.post(uri, body: parsePayload);
    return response;
  }
}
