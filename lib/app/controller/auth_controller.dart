import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/app/presentation/landing/landing_page.dart';

import '../../core/config/config.dart';
import '../../core/navigators/page_navigator.dart';
import '../../core/service/api.dart';
import '../../core/service/urls.dart';
import '../../core/shared_preference/shared_pref.dart';
import '../presentation/auth/otp_view.dart';
import '../presentation/auth/signup_view.dart';
import 'main_controller.dart';

class AuthController extends GetxController {
  TextEditingController mobileCtrl = TextEditingController();
  TextEditingController otpCtrl = TextEditingController();

  RxBool isLoaderBtn = false.obs;
  RxBool isValidation = false.obs;

  RxString responseOtp = "".obs;
  RxString isValidationText = "".obs;

  final formAuthKey = GlobalKey<FormState>();


  void sendOtp() {
    if (formAuthKey.currentState?.validate() == false) return;
    loginUser();
  }

  loginUser() async {
    isValidation.value = false;
    isValidationText.value = "";
    isLoaderBtn.value = true;
    try {
      final response = await Api.call(
          onRetryPressed: () => loginUser(),
          endPoint: loginUrl,
          body: {
            "phone_number": mobileCtrl.text.trim(),
          });
      if (response.success) {
        if (response.data["user"] == false) {
          responseOtp.value = response.data["otp"] ?? "";
          Screen.open(OtpView())?.then((value) {
            otpCtrl.text = '';
          });
        } else {
          accessToken = response.data["token"]["access"].toString();
          await SharedPref().save(key: "token", value: accessToken);
          Get.find<MainController>().getUserProfile();
          Screen.openAsNewPage(const LandingView());
        }
      }
    } finally {
      isLoaderBtn.value = false;
    }
  }

  resentOtp() {
    otpCtrl.text = '';
    loginUser();
  }

  verifyOtp() {
    if (otpCtrl.text.isEmpty) {
      isValidation.value = true;
      isValidationText.value = "Enter Otp";
      return;
    } else if (otpCtrl.text.length != 4) {
      isValidation.value = true;
      isValidationText.value = "invalid otp entered";
      return;
    } else if (otpCtrl.text != responseOtp.value) {
      isValidation.value = true;
      isValidationText.value = "invalid otp entered";
      return;
    }
    Screen.open(SignupView());
  }


  TextEditingController nameCtrl = TextEditingController();

  final formKey = GlobalKey<FormState>();

  signupFunction() async {
    isLoaderBtn.value = true;
    try {
      if (formKey.currentState!.validate()) {
        final response = await Api.call(
            onRetryPressed: () => signupFunction(),
            endPoint: signupUrl,
            body: {
              "first_name": nameCtrl.text.trim(),
              "phone_number": mobileCtrl.text,
            });
        if (response.success) {
          accessToken = response.data["token"]["access"];
          await SharedPref().save(key: "token", value: accessToken);
          Get.find<MainController>().getUserProfile();
          Screen.openAsNewPage(LandingView());
        }
      }
    } finally {
      isLoaderBtn.value = false;
    }
  }
}
