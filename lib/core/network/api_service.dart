import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Private constructor
  ApiService._privateConstructor();

  // Singleton instance
  static final ApiService _instance = ApiService._privateConstructor();

  // Factory constructor to return the same instance
  factory ApiService() {
    return _instance;
  }

  // Base URL
  final String _baseUrl = 'https://archgod.webdeveloperhisar.com/api';

  // API endpoints
  String get loginUrl => '$_baseUrl/login';
  String get forgetPassword => '$_baseUrl/forgetPassword';
  String get banner => '$_baseUrl/getBanner';
  String get productList => '$_baseUrl/getProductlist';


  // Generic GET request
  Future<http.Response> getRequest(String url, {Map<String, String>? headers}) async {
    final response = await http.get(Uri.parse(url), headers: headers);
    return response;
  }

  // Generic POST request
  Future<http.Response> postRequest(String url, Map<String, dynamic> body, {Map<String, String>? headers}) async {
    final response = await http.post(
      Uri.parse(url),
      headers: headers ?? {'Accept': 'application/json'},
      body: jsonEncode(body),
    );
    return response;
  }

  Future<http.StreamedResponse> postFormDataRequest(String url, Map<String, String> body) {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    body.forEach((key, value) {
      request.fields[key] = value;
    });

    return request.send();  // returns StreamedResponse
  }

  // Example of calling login API
  Future<http.Response> login(String email, String password) async {
    final formBody = {'email': email, 'password': password};
    final streamedResponse = await postFormDataRequest(loginUrl, formBody);
    return await http.Response.fromStream(streamedResponse);
  }

  Future<http.Response> forget_Password(String email) async {
    final formBody = {'email': email};
    final streamedResponse = await postFormDataRequest(forgetPassword, formBody);
    return await http.Response.fromStream(streamedResponse);
  }

  Future<http.Response> getBanner() async {
    final url = Uri.parse(banner); // Replace with your actual API URL
    return await http.get(url);
  }

  Future<http.Response> getProducts() async {
    final url = Uri.parse(productList); // Replace with your actual API URL
    return await http.get(url);
  }
}
