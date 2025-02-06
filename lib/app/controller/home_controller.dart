import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:test_app/core/config/config.dart';

import '../../core/service/api.dart';
import '../../core/service/urls.dart';
import '../model/banner_model.dart';
import '../model/product_model.dart';
import 'search_controller.dart';
import 'wishlist_controller.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    onRefresh();
  }

  onRefresh() {
    getBannersDetails();
    getProductsDetails();
  }

  RxList<BannerModel> bannerList = <BannerModel>[].obs;
  RxList<Product> allProducts = <Product>[].obs;
  RxBool isLoadingBanner = true.obs;
  RxBool isLoading = true.obs;

  List<Product> get popularProducts => allProducts
      .where((product) => product.avgRating != null && product.avgRating! >= 4)
      .toList()
    ..sort((a, b) => (b.avgRating ?? 0).compareTo(a.avgRating ?? 0));

  List<Product> get latestProducts => allProducts.toList()
    ..sort((a, b) =>
        (b.createdDate ?? '').compareTo(a.createdDate ?? '')); // Sort b

  Future<void> getBannersDetails() async {
    try {
      isLoadingBanner.value = true;
      final response = await Api.call(
        method: Method.get,
        onRetryPressed: () => getBannersDetails(),
        endPoint: bannersUrl,
      );

      if (response.success) {
        final banners = response.asList((json) => BannerModel.fromJson(json));
        bannerList.value = banners;
      }
    } catch (e) {
      debugPrint('Error loading banners: $e');
    } finally {
      isLoadingBanner.value = false;
    }
  }

  Future<void> getProductsDetails() async {
    try {
      isLoading.value = true;
      final response = await Api.call(
        method: Method.get,
        onRetryPressed: () => getProductsDetails(),
        endPoint: productsUrl,
      );

      if (response.success) {
        final products = response.asList((json) => Product.fromJson(json));
        allProducts.value = products;
      }
    } catch (e) {
      debugPrint('Error loading products: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addRemoveWishlist(int productId) async {
    try {
      final response = await Api.call(
          onRetryPressed: () => addRemoveWishlist(productId),
          endPoint: addRemoveWishlistUrl,
          body: {"product_id": productId});

      if (response.success) {
    
        final homeIndex =
            allProducts.indexWhere((product) => product.id == productId);
        if (homeIndex != -1) {
          final product = allProducts[homeIndex];
          product.inWishlist = !product.inWishlist!;
          allProducts[homeIndex] = product;
          allProducts.refresh();

        
          final wishlistController = Get.find<WishlistController>();
          if (!product.inWishlist!) {
            wishlistController.allProducts
                .removeWhere((p) => p.id == productId);
          } else {
            wishlistController.allProducts.add(product);
          }
          wishlistController.allProducts.refresh();

      
          if (Get.isRegistered<SearchProductsController>()) {
            Get.find<SearchProductsController>()
                .updateProductWishlistStatus(productId, product.inWishlist!);
          }
        }
        vibrateFn();
      }
    } catch (e) {
      debugPrint('Error updating wishlist: $e');
    }
  }
}
