import 'dart:async';

import 'package:get/get.dart';

class OtpController extends GetxController {
  Timer? _timer;
  RxString counter = ''.obs;
  RxBool isLoading = true.obs;
  RxBool isTimerRunning = false.obs; 

  @override
  void onInit() {
    startOtpCounting();
    super.onInit();
  }

  void startOtpCounting() {
    _timer?.cancel();
    int resendCount = 30;

    counter.value = "${resendCount}s";
    isTimerRunning.value = true; 

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer _) {
      resendCount = resendCount - 1;

      if (resendCount == 0) {
        _timer?.cancel();
        isLoading.value = false;
        isTimerRunning.value = false; 
        return;
      }

      final String count =
          resendCount < 10 ? "0$resendCount" : resendCount.toString();
      counter.value = "${count}s";
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
