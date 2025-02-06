import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/shared/widgets/hexColorCode.dart';

import '../../core/navigators/page_navigator.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const CustomBackButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell( 
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed ?? () => Screen.close(),
          child: Container(
            width: 46.w,
            height: 46.h,
            padding: const EdgeInsets.all(8),
            child: Icon(
              Icons.arrow_back_sharp,
              size: 25.sp,
              color: HexColor("#808080"),
            ),
          ),
        ),
      ),
    );
  }
}
