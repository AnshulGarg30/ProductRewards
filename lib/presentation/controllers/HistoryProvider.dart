import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../core/network/api_service.dart';
import '../../data/models/HistoryItem.dart';

class HistoryProvider extends ChangeNotifier {
  List<HistoryItem> _items = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<HistoryItem> get items => _items;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final api = ApiService();

  Future<void> fetchHistory(String userID) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await api.getHistoryList(userID);
      debugPrint("history response ${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if(data['status'] == true) {
          _items = (data['data'] as List)
              .map((json) => HistoryItem.fromJson(json))
              .toList();
        } else {
          _errorMessage = "Failed to fetch history (${data['message']})";
        }
      } else {
        _errorMessage = "Failed to fetch history (${response.statusCode})";
      }
    } catch (e) {
      _errorMessage = "Error: $e";
    }

    _isLoading = false;
    notifyListeners();
  }
}
