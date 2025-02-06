import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension NumberExtension on num {
  /// <b>SizedBox(height: 8)<b/>
  Widget get hBox => SizedBox(height: toDouble().h);

  /// <b>SizedBox(width: 8)<b/>
  Widget get wBox => SizedBox(width: toDouble().w);
}
