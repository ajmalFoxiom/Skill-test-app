import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_app/core/extensions/margin_ext.dart';
import 'package:test_app/shared/widgets/app_text_field.dart';
import '../../../shared/utils/get_validators.dart';
import '../../../shared/widgets/app_primary_btn.dart';
import '../../controller/auth_controller.dart';
import '../../widget/custom_back_button.dart';


class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(AuthController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Form(
            key: ctrl.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomBackButton(),
                40.hBox,
                AppTextField(
                  controller: ctrl.nameCtrl,
                  isOutlineBorder: false,
                  hint: "Enter Full Name",
                  borderClr: Colors.grey[300],
                  validator: (value) => validateRequired("Name", value),
                ),
                27.hBox,
                Obx(
                  () => AppPrimaryBtn(
                    isLoading: ctrl.isLoaderBtn.value,
                    borderRadius: 10.r,
                    onPressed: () => ctrl.signupFunction(),
                    text: "Submit",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
