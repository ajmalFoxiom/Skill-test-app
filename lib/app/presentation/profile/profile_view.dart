import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_app/core/extensions/margin_ext.dart';
import 'package:test_app/core/extensions/string_ext.dart';
import 'package:test_app/shared/widgets/hexColorCode.dart';

import '../../../shared/utils/constants.dart';
import '../../../shared/widgets/app_text.dart';
import '../../controller/main_controller.dart';
import '../../widget/logout_popup.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final mainCtrl = Get.find<MainController>();
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding:
              EdgeInsets.only(bottom: 16.h, top: 16.h, right: 16.w, left: 16.w),
          children: [
            Row(
              children: [
                AppText(
                  "My Profile",
                  family: oxygen700,
                  size: 18,
                ),
                Spacer(),
                IconButton(
                    onPressed: () => showPopUp(context),
                    icon: Icon(Icons.logout))
              ],
            ),
            38.hBox,
            AppText(
              "Name",
              family: oxygen700,
              size: 14,
              color: HexColor("#929292"),
            ),
            17.hBox,
            AppText(
              mainCtrl.profile.value?.name.toString().upperFirst,
              family: oxygen700,
              size: 18,
            ),
            24.hBox,
            AppText(
              "Phone",
              family: oxygen700,
              size: 14,
              color: HexColor("#929292"),
            ),
            17.hBox,
            AppText(
              "+91 ${mainCtrl.profile.value?.mobile.toString()}",
              family: oxygen700,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
