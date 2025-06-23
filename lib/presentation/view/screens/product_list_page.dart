import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/UserProvider.dart';
import '../../controllers/catelog_controller.dart';
import '../../controllers/product_controller.dart';
import '../../themes/colors.dart';
import '../widgets/ProductCard.dart';
import 'BannerCarousel.dart';
import 'ProductListScreen.dart';

class ProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ProductController>(context);
    final controllerCatelog = Provider.of<CatelogController>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const BannerCarousel(),

        const SizedBox(height: 20),
        Text(
          'Total Points: ${userProvider.userData?.totalPoint ?? '0'}',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            buildPointBox('Withdrawal\nPoints', userProvider.userData?.withdrawalPoint ?? '0'),
            buildPointBox('Remaining\nPoints', userProvider.userData?.remainingPoint ?? '0'),
            buildPointBox('Pending\nPoints', userProvider.userData?.pendingPoint ?? '0'),
          ],
        ),
        const SizedBox(height: 10),

        _buildSectionHeader(context, "Catalog", () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductListScreen(title: "All Catalogs"),
            ),
          );
        }),

        SizedBox(
          height: 230,
          child: _buildCatalogList(controllerCatelog),
        ),

        _buildSectionHeader(context, "Products", () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductListScreen(title: "All Products"),
            ),
          );
        }),

        SizedBox(
          height: 230,
          child: _buildProductList(controller),
        ),

        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildCatalogList(CatelogController controller) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
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
      shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
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

  Widget buildPointBox(String title, String value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.primary_shade,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 10),
            Text('$value',
                style:
                const TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
