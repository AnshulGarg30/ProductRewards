import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:productreward/data/models/RedeemRequestItem.dart';

import '../../core/network/api_service.dart';

class Redeemrequestprovider extends ChangeNotifier {
  List<RedeemRequestItem> _items = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<RedeemRequestItem> get items => _items;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final api = ApiService();

  Future<void> fetchRedeemRequest(String userID) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await api.getReedemRequestList(userID);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint("history response ${data}");
        if(data['status'] == true) {
          _items = (data['data'] as List)
              .map((json) => RedeemRequestItem.fromJson(json))
              .toList();
          debugPrint("history response ${_items.length}");

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
