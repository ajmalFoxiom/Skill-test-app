import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/landing_controller.dart';

import '../../widget/app_bottom_nav.dart';
import '../home/home_view.dart';
import '../profile/profile_view.dart';
import '../wishlist/wishlist_view.dart';

class LandingView extends StatelessWidget {
  const LandingView({super.key, this.currentIndex = 0});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(LandingController(currentIndex: currentIndex));

    List<Widget> pages = [
      HomeView(),
      WishlistView(),
      ProfileView(),
    ];

    return Obx(() => Scaffold(
          body: pages[ctrl.currentIndex.value],
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 12.h, right: 12.w, left: 12.w),
                child: AppBottomNav(
                    currentIndex: ctrl.currentIndex.value,
                    onTap: (index) => ctrl.setIndex(index)),
              ),
            ],
          ),
        ));
  }
}
