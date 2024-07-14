import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class BaseNetwork {
  static String baseUrl = 'http://localhost:8080/api';

  static Future<Map<String, dynamic>> get(String partUrl) async {
    final String fullUrl = "$baseUrl/$partUrl";
    final response = await http.get(Uri.parse(fullUrl));
    return _processResponse(response);
  }

  static Future<Map<String, dynamic>> getWithToken(
      String partUrl, String token) async {
    final String fullUrl = "$baseUrl/$partUrl";
    final response = await http.get(
      Uri.parse(fullUrl),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return _processResponse(response);
  }

  static Future<Map<String, dynamic>> putWithToken(
      String partUrl, String token, Map<String, dynamic> body) async {
    final String fullUrl = "$baseUrl/$partUrl";
    final response = await http.put(Uri.parse(fullUrl),
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(body));
    return _processResponse(response);
  }

  static Future<Map<String, dynamic>> post(
      String partUrl, Map<String, dynamic> body) async {
    final String fullUrl = "$baseUrl/$partUrl";
    final response = await http.post(
      Uri.parse(fullUrl),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
      },
      body: json.encode(body),
    );
    return _processResponse(response);
  }

  static Future<Map<String, dynamic>> postWithToken(
      String partUrl, String token, Map<String, dynamic> body) async {
    final String fullUrl = "$baseUrl/$partUrl";
    final response = await http.post(
      Uri.parse(fullUrl),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(body),
    );
    return _processResponse(response);
  }

  static Future<Map<String, dynamic>> multipart(String partUrl, String token,
      Map<String, dynamic> body, File file) async {
    final String fullUrl = "$baseUrl/$partUrl";
    var response = http.MultipartRequest('POST', Uri.parse(fullUrl));
    // final mimeType = lookupMimeType(imageName, headerBytes: imageBytes);
    // final mediaType = mimeType != null
    //     ? MediaType.parse(mimeType)
    //     : MediaType('image', 'png');
    // response.files.add();
    return _processResponse(response);
  }

  static Future<Map<String, dynamic>> _processResponse(
      http.Response response) async {
    final body = response.body;
    if (body.isNotEmpty) {
      final jsonBody = json.decode(body);
      return jsonBody;
    } else {
      return {"error": true};
    }
  }
}
