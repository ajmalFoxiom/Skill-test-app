import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/extensions/margin_ext.dart';
import 'package:test_app/shared/utils/constants.dart';

import '../../../../core/navigators/page_navigator.dart';
import '../../../../core/shared_preference/shared_pref.dart';
import '../../../../core/theme/colors.dart';
import '../../../../shared/widgets/app_text.dart';

void showPopUp(BuildContext ctx) {
  showCupertinoDialog(
    context: ctx,
    barrierDismissible: true,
    builder: (BuildContext context) => alertDialog(ctx),
  );
}

AlertDialog alertDialog(BuildContext ctx) {
  return AlertDialog(
    surfaceTintColor: Colors.white,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0))),
    content: const AppText(
      'Are you sure want to logout?',
      size: 16,
      family: oxygen400,
      align: TextAlign.center,
    ),
    actions: [
      AppText.click(
        'NO',
        family: oxygen700,
        color: primaryClr,
        onTap: () {
          Screen.close();
        },
      ),
      6.wBox,
      AppText.click(
        'YES, LOGOUT',
        color: primaryClr,
        family: oxygen700,
        onTap: () {
          SharedPref().logout();
        },
      ),
    ],
  );
}
