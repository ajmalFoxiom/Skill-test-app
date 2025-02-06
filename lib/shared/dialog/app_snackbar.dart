import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:test_app/shared/utils/constants.dart';

import '../widgets/app_text.dart';

bool isProcessing = false;
showOverlay({required String message, int? maxLines = 2}) async {
  BuildContext? context = Get.overlayContext;

  if (context == null) {
    // Fallback to print if context is not available
    if (kDebugMode) {
      print("Toast: $message");
    }
    return;
  }

  if (isProcessing) return;
  try {
    isProcessing = true;
    FToast flutterToast;
    flutterToast = FToast();
    flutterToast = flutterToast.init(context);
    Widget toast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6), color: Colors.black),
        child: AppText(
          message,
          family: oxygen700,
          size: 14,
          align: TextAlign.center,
          color: Colors.white,
        ));

    flutterToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 3),
    );
    await Future.delayed(const Duration(seconds: 3));
  } finally {
    isProcessing = false;
  }
}
