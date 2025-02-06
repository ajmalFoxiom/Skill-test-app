import 'package:flutter/animation.dart';
import 'package:get/get.dart';

import '../../core/navigators/page_navigator.dart';
import '../../core/shared_preference/shared_pref.dart';
import '../presentation/auth/login_view.dart';
import '../presentation/landing/landing_page.dart';
import 'main_controller.dart';


class SplashController extends GetxController
    // ignore: deprecated_member_use
    with
        SingleGetTickerProviderMixin {
  late AnimationController controller;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;

  @override
  void onInit() {
    super.onInit();
    _initAnimations();
    _navigateToNextScreen();
  }

  void _initAnimations() {
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    ));

    scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeOutBack,
    ));

    controller.forward();
  }

  void _navigateToNextScreen() async {
    String? accessToken = await SharedPref().getUserToken();
    Future.delayed(const Duration(seconds: 2), () {
      if (accessToken == null) {
        Screen.openAsNewPage(const LoginView());
      } else {
        _manageUserLogin();
      }
    });
  }

  void _manageUserLogin() async {
    await Get.find<MainController>().getUserProfile()
        ? Screen.openAsNewPage(const LandingView())
        : Screen.openAsNewPage(const LoginView());
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
