import 'package:flutter/material.dart';
import 'package:productreward/presentation/controllers/catelog_controller.dart';
import 'package:provider/provider.dart';

import '../../controllers/product_controller.dart';
import '../widgets/ProductCard.dart';

class ProductListScreen extends StatelessWidget {
  final String title;

  const ProductListScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ProductController>(context);
    final controller_Catelog = Provider.of<CatelogController>(context);

    final isCatalog = title.toLowerCase().contains("catalog");

    final isLoading = isCatalog
        ? controller_Catelog.isLoadingCatalogs
        : controller.isLoadingProducts;

    final errorMessage = isCatalog
        ? controller_Catelog.errorMessageCatalogs
        : controller.errorMessage;

    final items = isCatalog ? controller_Catelog.catalogs : controller.products;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body:
        // isLoading
      //     ? const Center(child: CircularProgressIndicator()):
            errorMessage != null
          ? Center(child: Text(errorMessage!))
          : items.isEmpty
          ? const Center(child: Text("No items available"))
          : ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 12.0, vertical: 8.0),
            child: ProductCard(
              data: items[index],
              type: isCatalog ? 'catalog' : 'product',
            ),
          );
        },
      ),
    );
  }
}
