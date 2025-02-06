import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_app/core/config/config.dart';
import 'package:test_app/core/extensions/margin_ext.dart';
import 'package:test_app/shared/utils/constants.dart';
import 'package:test_app/shared/widgets/app_text.dart';
import '../../../core/extensions/context_ext.dart';
import '../../controller/wishlist_controller.dart';
import '../../model/product_model.dart';
import '../../widget/empty_view.dart';
import '../../widget/product_card.dart';
import '../home/home_view.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WishlistController());
    return Scaffold(
      body: SafeArea(
        child: Obx(() => RefreshIndicator(
              onRefresh: () async {
                controller.getProductsDetails();
                vibrateFn();
              },
              child: ListView(
                children: [
                  22.hBox,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: AppText(
                      "Wishlist",
                      family: oxygen700,
                      size: 18,
                    ),
                  ),
                  8.hBox,
                  if (!controller.isLoading.value &&
                      controller.allProducts.isEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 130.h),
                      child: EmptyStateWidget(
                        message:
                            "No products available at the moment\nPlease check back later",
                      ),
                    ),
                  buildProductGrid(controller.isLoading.value,
                      controller.allProducts, context),
                ],
              ),
            )),
      ),
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
              Get.find<WishlistController>().addRemoveWishlist(product.id ?? 0),
        );
      },
    );
  }
}
