import 'package:flutter/material.dart';

Widget Function(BuildContext, Widget?)? appBuilder = (context, child) {
  return AccessibilityConfigWidget(
    child: ScrollConfiguration(
      behavior: ScrollBehaviorModified(),
      child: child!,
    ),
  );
};

class ScrollBehaviorModified extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const ClampingScrollPhysics();
}

class AccessibilityConfigWidget extends StatelessWidget {
  final Widget child;

  const AccessibilityConfigWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        boldText: false,
        textScaler: const TextScaler.linear(1.0),
      ),
      child: child,
    );
  }
}
