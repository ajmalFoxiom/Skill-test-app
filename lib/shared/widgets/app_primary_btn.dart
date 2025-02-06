import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/theme/colors.dart';
import 'package:test_app/shared/utils/constants.dart';

import 'app_text.dart';

class AppPrimaryBtn extends StatelessWidget {
  const AppPrimaryBtn({
    super.key,
    required this.text,
    this.onPressed,
    this.width,
    this.margin,
    this.isInvertedBtn = false,
    this.backgroundColor,
    this.txtClr,
    this.isLoading = false,
    this.isLocationBtn = false,
    this.isOutlinedBtn = false,
    this.isFullbgColor = false,
    this.icon,
    this.fontSize = 14,
    this.minHeight = 51,
    this.padding,
    this.constraints,
    this.borderClr,
    this.borderRadius,
    this.family,
  });

  final String text;
  final void Function()? onPressed;
  final double? width, fontSize, borderRadius, minHeight;
  final EdgeInsetsGeometry? margin;
  final bool isInvertedBtn;
  final Color? backgroundColor, txtClr, borderClr;
  final bool isOutlinedBtn, isFullbgColor, isLoading, isLocationBtn;

  final Widget? icon;
  final EdgeInsetsGeometry? padding;
  final BoxConstraints? constraints;
  final String? family;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      constraints: constraints ?? BoxConstraints(minHeight: minHeight!.h),
      width: width?.w ?? double.infinity,
      child: icon != null
          ? TextButton.icon(
              onPressed: isLoading ? null : onPressed,
              style: _buildBtnStyle(),
              icon: icon!,
              label: isLoading
                  ? isLocationBtn
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20.h,
                              width: 20.h,
                              child: const CupertinoActivityIndicator(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            _AnimatedEllipsis(
                              text: "Loading",
                              style: TextStyle(
                                color: txtClr ?? (Colors.white),
                                fontSize: fontSize?.sp ?? 14.sp,
                                fontFamily: family ?? oxygen700,
                              ),
                            ),
                          ],
                        )
                      : CupertinoActivityIndicator(color: Colors.white)
                  : BtnText(
                      text: text,
                      txtClr: txtClr,
                      isInvertedBtn: isInvertedBtn,
                      fontSize: fontSize?.sp,
                      family: family),
            )
          : TextButton(
              onPressed: isLoading ? null : onPressed,
              style: _buildBtnStyle(),
              child: isLoading
                  ? isLocationBtn
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20.h,
                              width: 20.h,
                              child: const CupertinoActivityIndicator(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            _AnimatedEllipsis(
                              text: "Loading",
                              style: TextStyle(
                                color: txtClr ?? (Colors.white),
                                fontSize: fontSize?.sp ?? 14.sp,
                                fontFamily: family ?? oxygen700,
                              ),
                            ),
                          ],
                        )
                      : CupertinoActivityIndicator(color: Colors.white)
                  : BtnText(
                      text: text,
                      txtClr: txtClr,
                      isInvertedBtn: isInvertedBtn,
                      fontSize: fontSize?.sp,
                      family: family),
            ),
    );
  }

  ButtonStyle _buildBtnStyle() {
    return TextButton.styleFrom(
      disabledBackgroundColor: isLoading
          ? isLocationBtn
              ? Colors.grey
              : null
          : Colors.grey,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 20.w),

      backgroundColor: isFullbgColor
          ? backgroundColor
          : (isOutlinedBtn
              ? null
              : (isInvertedBtn ? Colors.white : backgroundColor ?? primaryClr)),
      // Background color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 6.0),
        side: isOutlinedBtn || borderClr != null
            ? BorderSide(color: borderClr ?? backgroundColor!)
            : BorderSide.none,
      ),
    );
  }
}

class BtnText extends StatelessWidget {
  const BtnText({
    super.key,
    required this.text,
    required this.txtClr,
    required this.isInvertedBtn,
    required this.fontSize,
    this.family,
  });

  final String text;
  final Color? txtClr;
  final bool isInvertedBtn;
  final double? fontSize;
  final String? family;

  @override
  Widget build(BuildContext context) {
    return AppText(text,
        color: txtClr ?? (isInvertedBtn ? primaryClr : Colors.white),
        family: family ?? oxygen700,
        size: fontSize);
  }
}

class _AnimatedEllipsis extends StatefulWidget {
  final String text;
  final TextStyle style;

  const _AnimatedEllipsis({
    required this.text,
    required this.style,
  });

  @override
  _AnimatedEllipsisState createState() => _AnimatedEllipsisState();
}

class _AnimatedEllipsisState extends State<_AnimatedEllipsis>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _dotCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..addListener(() {
        setState(() {
          _dotCount = (_controller.value * 3).floor();
        });
      });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.text, style: widget.style),
        SizedBox(
          width: 24.w,
          child: Text(
            '.' * _dotCount,
            style: widget.style,
          ),
        ),
      ],
    );
  }
}
