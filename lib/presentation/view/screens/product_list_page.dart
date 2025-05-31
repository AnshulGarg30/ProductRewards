import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/product_controller.dart';
import '../widgets/ProductCard.dart';
import 'BannerCarousel.dart';

class ProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ProductController>(context);

    return Scaffold(
      body: Column(
        children: [
          const BannerCarousel(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Products",
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),// Banner just below appbar
          controller.isLoading
              ? const Expanded(child: Center(child: CircularProgressIndicator()))
              : controller.errorMessage != null
              ? Expanded(child: Center(child: Text(controller.errorMessage!)))
              : Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  final product = controller.products[index];
                  return ProductCard(product: product);
                },
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
    );

  }
}
