import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../shared/widgets/app_svg.dart';
import '../../controller/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(SplashController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: ctrl.controller,
          builder: (context, child) {
            return FadeTransition(
              opacity: ctrl.fadeAnimation,
              child: ScaleTransition(
                scale: ctrl.scaleAnimation,
                child: AppSvg(
                  assetName: "Logo",
                  width: 100.w,
                  height: 100.h,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
