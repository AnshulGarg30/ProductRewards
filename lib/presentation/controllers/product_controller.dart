import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:productreward/core/network/api_service.dart';
import '../../data/models/Product.dart';

class ProductController extends ChangeNotifier {
  List<Product> products = [];

  bool isLoadingProducts = false;

  String? errorMessage;

  final ApiService _api = ApiService();

  Future<void> fetchProducts() async {
    isLoadingProducts = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await _api.getProducts();
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] == true) {
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
      isLoadingProducts = false;
      notifyListeners();
    }
  }

}
