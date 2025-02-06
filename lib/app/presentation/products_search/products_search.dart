import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_app/app/controller/home_controller.dart';
import 'package:test_app/core/extensions/margin_ext.dart';

import '../../../core/extensions/context_ext.dart';
import '../../controller/search_controller.dart';
import '../../model/product_model.dart';
import '../../widget/custom_search_bar.dart';
import '../../widget/empty_view.dart';
import '../../widget/product_card.dart';
import '../home/home_view.dart';

class ProductsSearch extends StatelessWidget {
  const ProductsSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchProductsController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Obx(
        () => Column(
          children: [
            16.hBox,
            CustomSearchBar(
              controller: controller.searchCtrl,
              onChanged: (value) {
                Future.delayed(const Duration(milliseconds: 500), () {
                  if (value == controller.searchCtrl.text) {
                    controller.getProductsDetails(value);
                  }
                });
              },
            ),
            Expanded(
              child: ListView(
                children: [
                  22.hBox,
                  if (!controller.isLoading.value &&
                      controller.allProducts.isEmpty)
                    EmptyStateWidget(
                      message: "No product available",
                    ),
                  buildProductGrid(controller.isLoading.value,
                      controller.allProducts, context),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget buildProductGrid(
      bool isLoading, List<Product> products, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = getCrossAxisCount(screenWidth);
    double aspectRatio = getAspectRatio(screenWidth);
    double crossAxisSpacing = getCrossAxisSpacing(screenWidth);
    double mainAxisSpacing = getMainAxisSpacing(screenWidth);
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: aspectRatio,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
      ),
      itemCount: isLoading ? 4 : products.length,
      itemBuilder: (context, index) {
        if (isLoading) {
          return ShimmerProductCard();
        }
        final product = products[index];
        return ProductCard(
          title: product.name ?? "",
          imagePath: product.featuredImage ?? "",
          originalPrice: product.mrp?.toDouble() ?? 0,
          discountedPrice: product.salePrice?.toDouble() ?? 0,
          rating: product.avgRating?.toDouble() ?? 0,
          inWishlist: product.inWishlist,
          onPressed: () =>
              Get.find<HomeController>().addRemoveWishlist(product.id ?? 0),
        );
      },
    );
  }
}
