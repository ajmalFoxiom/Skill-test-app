import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:get/get.dart';
import 'package:test_app/shared/widgets/hexColorCode.dart';

import '../../app/model/banner_model.dart';

class ImageSlider extends StatelessWidget {
  final RxList<BannerModel> imageList;
  final double height;
  final bool autoPlay;
  final RxInt currentIndex = 0.obs;

  ImageSlider({
    super.key,
    required this.imageList,
    this.height = 200,
    this.autoPlay = true,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (imageList.isEmpty) {
        return EmptyBannerState(height: height);
      }

      return Column(
        children: [
          CarouselSlider.builder(
            itemCount: imageList.length,
            options: CarouselOptions(
              height: height,
              viewportFraction: 1.0,
              autoPlay: autoPlay,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              onPageChanged: (index, reason) {
                currentIndex.value = index;
              },
            ),
            itemBuilder: (context, index, realIndex) {
              return BannerImage(
                imageUrl: imageList[index].image ?? "",
                height: height,
              );
            },
          ),
          Obx(() => DotsIndicator(
                dotsCount: imageList.length,
                position: currentIndex.value.toInt(),
                decorator: DotsDecorator(
                  activeColor: HexColor("#2B4248"),
                  size: Size.square(6.h),
                  activeSize: Size(20.w, 6.h),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              )),
        ],
      );
    });
  }
}

class BannerImage extends StatelessWidget {
  final String imageUrl;
  final double height;

  const BannerImage({
    super.key,
    required this.imageUrl,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrl,
          fit: BoxFit.fill,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return BannerShimmer(height: height);
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: height,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Icon(
                  Icons.error_outline,
                  color: Colors.grey,
                  size: 40,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class BannerShimmer extends StatelessWidget {
  final double height;

  const BannerShimmer({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class EmptyBannerState extends StatelessWidget {
  final double height;

  const EmptyBannerState({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_not_supported_outlined,
            size: 40,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 8),
          Text(
            'No banners available',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
