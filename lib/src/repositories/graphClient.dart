import 'dart:convert';

import 'package:http/http.dart';

class GraphClient {
  final String _apiUrl =
      'https://resman-web-admin-api.herokuapp.com/graph?lng=vi';
  Map<String, String> _headers;
  Map<String, String> _body;
  Client _client;

  GraphClient() {
    _headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    _body = {};
    _client = Client();
  }

  authorization(String token) {
    _headers.addAll({'Authorization': token});
    return this;
  }

  addHeader(Map<String, String> headers) {
    _headers.addAll(headers);
    return this;
  }

  addBody(String body) {
    _body.addAll({'query': body});
    return this;
  }

  connect() async {
    final response =
        await _client.post(_apiUrl, headers: _headers, body: _body);
    final decoded = jsonDecode(response.body);

    _client.close();

    if (response.statusCode == 200 && decoded['errors'] == null) {
      return decoded['data'];
    } else {
      print(decoded['errors']);
      throw decoded['errors'][0]['message'] ?? 'Lỗi kết nối';
    }
  }

  close() => _client.close();
}
