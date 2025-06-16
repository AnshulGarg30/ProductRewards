import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:productreward/core/network/api_service.dart';
import '../../data/models/Catelog.dart';

class CatelogController extends ChangeNotifier {
  List<Catelog> catalogs = [];

  bool isLoadingCatalogs = false;

  String? errorMessageCatalogs;

  final ApiService _api = ApiService();

  Future<void> fetchCatelogs() async {
    isLoadingCatalogs = true;
    errorMessageCatalogs = null;
    notifyListeners();

    try {
      final response = await _api.getCatelogs();
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] == true) {
          final List<dynamic> data = jsonResponse['data'];
          print("catelog list json ${data}");
          catalogs = data.map((e) => Catelog.fromJson(e)).toList();
          print("catelog list data ${catalogs}");
        } else {
          errorMessageCatalogs = jsonResponse['message'] ?? 'Unknown error';
        }
      } else {
        errorMessageCatalogs = 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      errorMessageCatalogs = 'Failed to fetch Catelog products: $e';
    } finally {
      isLoadingCatalogs = false;
      notifyListeners();
    }
  }
}
