import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ContextExtension on BuildContext {
  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  MediaQueryData get device => MediaQuery.of(this);

  Size get deviceSize => MediaQuery.of(this).size;
}


int getCrossAxisCount(double screenWidth) {
  if (screenWidth > 1200) {
    return 4; // Extra large screens
  } else if (screenWidth > 900) {
    return 3; // Large screens
  } else if (screenWidth > 600) {
    return 2; // Medium screens
  }
  return 2; // Small screens
}

double getAspectRatio(double screenWidth) {
  if (screenWidth > 1200) {
    return 0.75; // Extra large screens
  } else if (screenWidth > 900) {
    return 0.70; // Large screens
  } else if (screenWidth > 600) {
    return 0.65; // Medium screens
  }
  return 0.67; // Small screens
}

double getHorizontalPadding(double screenWidth) {
  if (screenWidth > 1200) {
    return 32.0; // Extra large screens
  } else if (screenWidth > 900) {
    return 24.0; // Large screens
  } else if (screenWidth > 600) {
    return 20.0; // Medium screens
  }
  return 16.0; // Small screens
}

double getCrossAxisSpacing(double screenWidth) {
  if (screenWidth > 1200) {
    return 24.0; // Extra large screens
  } else if (screenWidth > 900) {
    return 20.0; // Large screens
  }
  return 16.0; // Medium and small screens
}

double getMainAxisSpacing(double screenWidth) {
  if (screenWidth > 1200) {
    return 16.0; // Extra large screens
  } else if (screenWidth > 900) {
    return 12.0; // Large screens
  }
  return 1; // Medium and small screens
}

int getShimmerCount(double screenWidth) {
  if (screenWidth > 1200) {
    return 8; // Extra large screens
  } else if (screenWidth > 900) {
    return 6; // Large screens
  }
  return 4; // Medium and small screens
}
