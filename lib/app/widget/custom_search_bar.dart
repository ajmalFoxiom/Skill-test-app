import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/theme/colors.dart';
import 'package:test_app/shared/utils/constants.dart';
import 'package:test_app/shared/widgets/app_svg.dart';
import 'package:test_app/shared/widgets/hexColorCode.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final void Function()? onSearchTap;

  const CustomSearchBar({
    super.key,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: 48.h,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: onSearchTap,
                child: IgnorePointer(
                  ignoring: onSearchTap != null,
                  child: TextField(
                    autofocus: onSearchTap == null,
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    controller: controller,
                    onChanged: onChanged,
                    onSubmitted: onSubmitted,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                          color: hintClr,
                          fontSize: 14.sp,
                          fontFamily: oxygen400),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 1.5.w,
              height: 25,
              color: HexColor("#2B4248"),
              margin: const EdgeInsets.symmetric(horizontal: 12),
            ),
            AppSvg(assetName: "search")
          ],
        ),
      ),
    );
  }
}
