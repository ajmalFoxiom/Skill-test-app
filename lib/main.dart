import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app/controller/main_controller.dart';
import 'app/presentation/splash/splash_page.dart';
import 'core/config/scroll_behaviour.dart';
import 'core/theme/app_theme.dart';
import 'shared/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: false,
      child: GetMaterialApp(
        initialBinding: BindingsBuilder(() {
          Get.put(MainController());
        }),
        title: appName,
        theme: appTheme,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        builder: appBuilder,
        home: const SplashPage(),
      ),
    );
  }
}
