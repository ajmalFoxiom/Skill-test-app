import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_app/core/extensions/margin_ext.dart';
import 'package:test_app/core/theme/colors.dart';
import 'package:test_app/shared/utils/constants.dart';
import 'package:test_app/shared/widgets/app_text.dart';
import 'package:test_app/shared/widgets/hexColorCode.dart';

import '../../../shared/widgets/app_primary_btn.dart';
import '../../controller/auth_controller.dart';
import '../../controller/otp_controller.dart';
import '../../widget/custom_back_button.dart';
import 'otp_text_field.dart';


class OtpView extends StatelessWidget {
  const OtpView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final otpController = Get.put(OtpController());
    final ctrl = Get.put(AuthController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBackButton(),
              40.hBox,
              AppText(
                "OTP VERIFICATION",
                size: 18,
                family: oxygen700,
              ),
              16.hBox,
              RichText(
                text: TextSpan(
                  text: 'Enter the OTP sent to ',
                  style: TextStyle(
                      color: HexColor("#4E4D4D"),
                      fontSize: 14.sp,
                      fontFamily: oxygen400),
                  children: [
                    TextSpan(
                      text: '- +91-${ctrl.mobileCtrl.text}',
                      style: TextStyle(
                          color: blackClr,
                          fontFamily: oxygen700,
                          fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
              40.hBox,
              Obx(
                () => RichText(
                  text: TextSpan(
                    text: 'OTP is ',
                    style: TextStyle(
                        color: blackClr,
                        fontSize: 15.sp,
                        fontFamily: oxygen700),
                    children: [
                      TextSpan(
                        text: ctrl.responseOtp.value,
                        style: TextStyle(
                            color: primaryClr,
                            fontFamily: oxygen700,
                            fontSize: 18.sp),
                      ),
                    ],
                  ),
                ),
              ),
              40.hBox,
              Obx(
                () => OTPInputFields(
                  isVlidation: ctrl.isValidation.value,
                  onCompleted: (otp) {
                    ctrl.otpCtrl.text = otp;
                  },
                ),
              ),
              6.hBox,
              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: AppText(
                    ctrl.isValidationText.value,
                    color: Colors.red,
                  ),
                ),
              ),
              8.hBox,
              Obx(() {
                return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText("Didn't receive the code?",
                          family: oxygen400, color: HexColor("#5A5A5A")),
                      AppText.click(
                          otpController.isTimerRunning.isTrue
                              ? otpController.counter.value
                              : "Send again",
                          family: oxygen700,
                          color: HexColor("#00E5A4"), onTap: () {
                        otpController.isTimerRunning.isTrue
                            ? null
                            : ctrl.resentOtp();
                        otpController.isTimerRunning.isTrue
                            ? null
                            : otpController.startOtpCounting();
                      }),
                    ]);
              }),
              34.hBox,
              Obx(
                () => AppPrimaryBtn(
                  isLoading: ctrl.isLoaderBtn.value,
                  borderRadius: 10.r,
                  onPressed: () => ctrl.verifyOtp(),
                  text: "Submit",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
