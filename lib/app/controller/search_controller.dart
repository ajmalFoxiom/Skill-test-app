import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/service/api.dart';
import '../../core/service/urls.dart';

import '../model/product_model.dart';
import 'home_controller.dart';

class SearchProductsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getProductsDetails("");
  }

  RxList<Product> allProducts = <Product>[].obs;
  RxBool isLoading = true.obs;
  TextEditingController searchCtrl = TextEditingController();

  Future<void> getProductsDetails(String value) async {
    try {
      isLoading.value = true;
      final response = await Api.call(
        isShowToast: false,
        body: {"query": value.trim()},
        onRetryPressed: () => getProductsDetails(value),
        endPoint: searchUrl,
      );

      if (response.success) {
        final products = response.asList((json) => Product.fromJson(json));


        final homeController = Get.find<HomeController>();
        for (var searchProduct in products) {
          final homeProduct = homeController.allProducts
              .firstWhereOrNull((p) => p.id == searchProduct.id);
          if (homeProduct != null) {
            searchProduct.inWishlist = homeProduct.inWishlist;
          }
        }

        allProducts.value = products;
      } else {
        allProducts.value = [];
      }
    } catch (e) {
      debugPrint('Error loading products: $e');
    } finally {
      isLoading.value = false;
    }
  }

 
  void updateProductWishlistStatus(int productId, bool isWishlist) {
    final index = allProducts.indexWhere((product) => product.id == productId);
    if (index != -1) {
      final product = allProducts[index];
      product.inWishlist = isWishlist;
      allProducts[index] = product;
      allProducts.refresh();
    }
  }
}
