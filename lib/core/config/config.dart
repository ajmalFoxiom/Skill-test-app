import 'package:flutter/services.dart';

String? accessToken;

vibrateFn() async {
  await HapticFeedback.lightImpact();
}
