import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/catelog_controller.dart';
import '../../controllers/product_controller.dart';
import '../widgets/ProductCard.dart';
import 'BannerCarousel.dart';
import 'ProductListScreen.dart';

class ProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ProductController>(context);
    final controllerCatelog = Provider.of<CatelogController>(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BannerCarousel(),

              /// ---- CATALOG SECTION ----
              _buildSectionHeader(context, "Catalog", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductListScreen(title: "All Catalogs"),
                  ),
                );
              }),

              SizedBox(
                height: 230,
                child: _buildCatalogList(controllerCatelog),
              ),

              /// ---- PRODUCTS SECTION ----
              _buildSectionHeader(context, "Products", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductListScreen(title: "All Products"),
                  ),
                );
              }),

              SizedBox(
                height: 230,
                child: _buildProductList(controller),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCatalogList(CatelogController controller) {
    print("catelog list ${controller.catalogs.length}");
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: controller.catalogs.length >= 4
          ? 4
          : controller.catalogs.length,
      itemBuilder: (context, index) {
        final catalog = controller.catalogs[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ProductCard(data: catalog, type: 'catalog'),
        );
      },
    );
  }

  Widget _buildProductList(ProductController controller) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: controller.products.length >= 4
          ? 4
          : controller.products.length,
      itemBuilder: (context, index) {
        final product = controller.products[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ProductCard(data: product, type: 'product'),
        );
      },
    );
  }

  Widget _buildSectionHeader(
      BuildContext context, String title, VoidCallback onViewMore) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:
              const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          TextButton(
            onPressed: onViewMore,
            child: const Text("View More"),
          ),
        ],
      ),
    );
  }
}
