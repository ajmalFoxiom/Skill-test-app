import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/shared/utils/constants.dart';
import 'package:test_app/shared/widgets/app_text.dart';
import '../../shared/widgets/app_svg.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const menus = [
    NavItem(icon: 'home', label: 'Home'),
    NavItem(icon: 'wishlist', label: 'Wishlist'),
    NavItem(icon: 'profile', label: 'Profile'),
  ];

  final int currentIndex;
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(74.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            menus.length,
            (index) => _buildNavButton(
              isSelected: currentIndex == index,
              item: menus[index],
              onPressed: () => onTap(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton({
    required bool isSelected,
    required NavItem item,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF6C63FF) : Colors.transparent,
        borderRadius: BorderRadius.circular(45.r),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(45.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            BnvIcon(
              iconName: item.icon,
              color: isSelected ? Colors.white : Colors.grey,
            ),
            if (isSelected)
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: AppText(
                  item.label,
                  family: oxygen700,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class BnvIcon extends StatelessWidget {
  const BnvIcon({
    super.key,
    required this.iconName,
    required this.color,
  });

  final String iconName;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: AppSvg(assetName: iconName, color: color),
    );
  }
}

class NavItem {
  final String icon;
  final String label;

  const NavItem({
    required this.icon,
    required this.label,
  });
}
