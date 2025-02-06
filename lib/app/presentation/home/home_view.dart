import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:test_app/core/config/config.dart';
import 'package:test_app/core/extensions/margin_ext.dart';
import 'package:test_app/core/navigators/page_navigator.dart';
import 'package:test_app/shared/utils/constants.dart';
import 'package:test_app/shared/widgets/app_text.dart';

import '../../../core/theme/colors.dart';
import '../../../shared/widgets/image_slider.dart';
import '../../controller/home_controller.dart';
import '../../model/product_model.dart';
import '../../widget/custom_search_bar.dart';
import '../../widget/empty_view.dart';
import '../../widget/product_card.dart';
import '../products_search/products_search.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Obx(() => Padding(
                padding: EdgeInsets.only(bottom: 0.h, top: 16.h),
                child: Column(
                  children: [
                    CustomSearchBar(
                        onSearchTap: () => Screen.open(
                              ProductsSearch(),
                            )),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await controller.getBannersDetails();
                          controller.getProductsDetails();
                          vibrateFn();
                        },
                        child: ListView(
                          children: [
                            16.hBox,
                            controller.isLoadingBanner.value
                                ? ShimmerWidget(height: 200)
                                : ImageSlider(
                                    imageList: controller.bannerList,
                                    height: 200,
                                    autoPlay: true,
                                  ),
                            buildSectionHeader("Popular Products"),
                            8.hBox,
                            if (!controller.isLoading.value &&
                                controller.popularProducts.isEmpty)
                              EmptyStateWidget(
                                message:
                                    "No products available at the moment\nPlease check back later",
                              ),

                            buildProductGrid(
                              controller.isLoading.value,
                              controller.popularProducts,
                            ),

                            16.hBox,

                          
                            buildSectionHeader("Latest Products"),
                            8.hBox,
                            if (!controller.isLoading.value &&
                                controller.latestProducts.isEmpty)
                              EmptyStateWidget(
                                message:
                                    "No products available at the moment\nPlease check back later",
                              ),
                            buildProductGrid(
                              controller.isLoading.value,
                              controller.latestProducts,
                            ),
                            100.hBox
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ))),
    );
  }

  Widget buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            title,
            family: oxygen700,
            size: 18,
            color: headingClr,
          ),
        ],
      ),
    );
  }

  Widget buildProductGrid(bool isLoading, List<Product> products) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.74.h,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 12.h,
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

class ShimmerProductCard extends StatelessWidget {
  const ShimmerProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          8.hBox,
          Container(
            height: 20,
            width: 100,
            color: Colors.white,
          ),
          8.hBox,
          Container(
            height: 16,
            width: 80,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class ShimmerWidget extends StatelessWidget {
  final double height;

  const ShimmerWidget({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }
}
