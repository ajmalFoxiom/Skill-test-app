import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:test_app/core/extensions/margin_ext.dart';
import 'package:test_app/core/theme/colors.dart';
import 'package:test_app/shared/utils/constants.dart';
import 'package:test_app/shared/widgets/app_svg.dart';
import 'package:test_app/shared/widgets/app_text.dart';
import 'package:test_app/shared/widgets/hexColorCode.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final double originalPrice;
  final double discountedPrice;
  final double rating;
  final bool? inWishlist;
  final Function()? onPressed;

  const ProductCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.originalPrice,
    required this.discountedPrice,
    required this.rating,
    this.inWishlist,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.r),
                ),
                child: CachedNetworkImage(
                  imageUrl: imagePath,
                  height: 176.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 150.h,
                      color: Colors.white,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 150.h,
                    color: Colors.grey[100],
                    child: Icon(Icons.error_outline, color: Colors.grey),
                  ),
                ),
              ),
              if (originalPrice > discountedPrice)
                Positioned(
                  left: 8,
                  top: 8,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: primaryClr,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: AppText(
                      "${((originalPrice - discountedPrice) / originalPrice * 100).toStringAsFixed(0)}% OFF",
                      color: Colors.white,
                      size: 12,
                      family: oxygen700,
                    ),
                  ),
                ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: EdgeInsets.all(1.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: AppSvg.clickable(
                    assetName: inWishlist == true ? "like_button" : "wishlist",
                    onPressed: onPressed,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (originalPrice > discountedPrice)
                      AppText(
                        '₹${originalPrice.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: oxygen400,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: HexColor("#999BA9"),
                          color: HexColor("#797C90"),
                        ),
                      ),
                    if (originalPrice > discountedPrice) 8.wBox,
                    AppText(
                      '₹${discountedPrice.toStringAsFixed(0)}',
                      color: primaryClr,
                      family: oxygen700,
                      size: 16,
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: HexColor("#FA964C"),
                          size: 16,
                        ),
                        4.wBox,
                        AppText(
                          rating.toString(),
                          family: oxygen400,
                          size: 12,
                          color: HexColor("#1D2348"),
                        ),
                      ],
                    ),
                  ],
                ),
                4.hBox,
                AppText(
                  title,
                  size: 14,
                  family: oxygen700,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                4.hBox,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
