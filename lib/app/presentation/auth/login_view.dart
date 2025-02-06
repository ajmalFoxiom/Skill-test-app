import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_app/core/extensions/margin_ext.dart';
import 'package:test_app/shared/utils/constants.dart';
import 'package:test_app/shared/widgets/app_text.dart';
import 'package:test_app/shared/widgets/app_text_field.dart';

import '../../../core/theme/colors.dart';
import '../../../shared/utils/get_validators.dart';
import '../../../shared/widgets/app_primary_btn.dart';
import '../../controller/auth_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(AuthController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: ctrl.formAuthKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                60.hBox,
                AppText(
                  'Login',
                  family: oxygen700,
                  size: 35,
                ),
                10.hBox,
                AppText(
                  'Let\'s Connect with Lorem ipsum.',
                  color: loginSubClr,
                  family: manrope400,
                  size: 14,
                ),
                40.hBox,
                AppTextField(
                  controller: ctrl.mobileCtrl,
                  keyboardType: TextInputType.phone,
                  autofillHints: const [AutofillHints.telephoneNumber],
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  isOutlineBorder: false,
                  borderClr: Colors.grey[300],
                  prefixIcon: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const AppText(
                          '+91',
                          family: oxygen400,
                          color: hintClr,
                        ),
                        Container(
                          height: 24,
                          width: 1,
                          color: Colors.grey[300],
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                      ],
                    ),
                  ),
                  validator: (value) => validatePhone(value),
                  hint: "Enter Phone",
                ),
                27.hBox,
                Obx(
                  () => AppPrimaryBtn(
                    isLoading: ctrl.isLoaderBtn.value,
                    borderRadius: 10.r,
                    onPressed: () => ctrl.sendOtp(),
                    text: "Continue",
                  ),
                ),
                27.hBox,
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                          fontFamily: oxygen300,
                          color: blackClr,
                          fontSize: 10.sp),
                      children: [
                        const TextSpan(text: 'By continuing you agree to the '),
                        TextSpan(
                          text: 'Terms of Use &\n',
                          style: TextStyle(
                            color: blackClr,
                            fontSize: 10.sp,
                            fontFamily: oxygen400,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                            color: blackClr,
                            fontFamily: oxygen400,
                            fontSize: 10.sp,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
