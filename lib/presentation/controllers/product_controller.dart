import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:productreward/core/network/api_service.dart';

import '../../data/models/Product.dart';

class ProductController extends ChangeNotifier {
  List<Product> products = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchProducts() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final api = ApiService();
      final response = await api.getProducts();
      print("productlist ${response.body}");
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] == true) {
          print("productlist2 ${jsonResponse}");
          final List<dynamic> data = jsonResponse['data'];
          products = data.map((e) => Product.fromJson(e)).toList();
        } else {
          errorMessage = jsonResponse['message'] ?? 'Unknown error';
        }
      } else {
        errorMessage = 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage = 'Failed to fetch products: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
