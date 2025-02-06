import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../core/config/config.dart';
import '../../core/service/api.dart';
import '../../core/service/urls.dart';

import '../model/product_model.dart';
import 'home_controller.dart';

class WishlistController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    getProductsDetails();
  }

  RxList<Product> allProducts = <Product>[].obs;
  RxBool isLoading = true.obs;

  Future<void> getProductsDetails() async {
    try {
      isLoading.value = true;
      final response = await Api.call(
        method: Method.get,
        onRetryPressed: () => getProductsDetails(),
        endPoint: wishlistUrl,
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
       
        allProducts.removeWhere((product) => product.id == productId);
        allProducts.refresh();

        
        final homeController = Get.find<HomeController>();
        final homeIndex = homeController.allProducts
            .indexWhere((product) => product.id == productId);

        if (homeIndex != -1) {
          final product = homeController.allProducts[homeIndex];
          product.inWishlist = false;
          homeController.allProducts[homeIndex] = product;
          homeController.allProducts.refresh();
        }
          vibrateFn();
      }
    } catch (e) {
      debugPrint('Error updating wishlist: $e');
    }
  }
}
