import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/extensions/margin_ext.dart';
import 'package:test_app/core/theme/colors.dart';

import '../../shared/utils/constants.dart';

import '../../shared/widgets/app_text.dart';

class EmptyStateWidget extends StatelessWidget {
  final String message;
  final String? imagePath;
  final VoidCallback? onRetry;
  final double? imageSize;

  const EmptyStateWidget({
    super.key,
    required this.message,
    this.imagePath,
    this.onRetry,
    this.imageSize,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              message,
              family: oxygen400,
              size: 16,
              color: Colors.grey[600],
              align: TextAlign.center,
            ),
            if (onRetry != null) ...[
              16.hBox,
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryClr,
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: AppText(
                  'Retry',
                  color: Colors.white,
                  family: oxygen700,
                  size: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
