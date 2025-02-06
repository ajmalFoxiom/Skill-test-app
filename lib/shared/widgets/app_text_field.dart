import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/theme/colors.dart';

import '../utils/constants.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {super.key,
      this.hint,
      this.maxLines,
      this.controller,
      this.isOutlineBorder = true,
      this.labelText,
      this.prefixIcon,
      this.hintColor,
      this.bgColor,
      this.borderClr,
      this.style,
      this.textFieldHeight,
      this.borderRadius,
      this.suffixText,
      this.suffixIcon,
      this.suffixStyle,
      this.onChanged,
      this.readOnly = false,
      this.onTap,
      this.keyboardType,
      this.textAlign,
      this.textInputAction,
      this.onEditingComplete,
      this.inputFormatters,
      this.autofillHints,
      this.focusNode,
      this.validator});

  final String? hint, labelText, suffixText;
  final TextEditingController? controller;
  final bool isOutlineBorder;
  final int? maxLines;
  final Color? bgColor, borderClr, hintColor;
  final Widget? prefixIcon, suffixIcon;
  final TextStyle? style, suffixStyle;
  final double? borderRadius, textFieldHeight;

  final void Function(String)? onChanged;
  final void Function()? onTap;
  final TextInputType? keyboardType;

  final bool readOnly;

  final TextAlign? textAlign;
  final TextInputAction? textInputAction;
  final Function()? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final Iterable<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    return onTap != null
        ? InkWell(
            onTap: onTap,
            child: IgnorePointer(ignoring: true, child: buildBtn()))
        : buildBtn();
  }

  Container buildBtn() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: inputFiledVMargin),
      child: TextFormField(
        onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        validator: validator,
        //  textInputAction: TextInputAction.done,
        autofillHints: autofillHints,

        focusNode: focusNode,
        inputFormatters: inputFormatters,
        onEditingComplete: onEditingComplete,
        controller: controller,
        textInputAction: textInputAction ?? TextInputAction.next,
        cursorColor: blackClr,
        maxLines: maxLines,
        style: style,
        onChanged: onChanged,
        enabled: true,
        keyboardType: keyboardType,
        readOnly: onTap != null ? true : readOnly,
        textAlign: textAlign ?? TextAlign.start,
        decoration: InputDecoration(
            fillColor: bgColor,
            filled: bgColor == null ? false : true,
            hintText: hint,
            suffixText: suffixText,
            suffixStyle: suffixStyle,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: TextStyle(
                color: headingClr, fontFamily: manrope400, fontSize: 13.sp),
            hintStyle: TextStyle(
                fontFamily: oxygen400,
                fontSize: 14.sp,
                color: hintColor ?? hintClr),
            border: _setBorder(),
            enabledBorder:
                _setBorder(borderClr: borderClr, borderRadius: borderRadius),
            focusedBorder: _setBorder(
                borderClr: borderClr ?? primaryClr, borderRadius: borderRadius),
            disabledBorder: _setBorder(),
            contentPadding: EdgeInsets.symmetric(
                horizontal: isOutlineBorder ? 20 : 4,
                vertical: textFieldHeight ?? 14)),
      ),
    );
  }

  InputBorder _setBorder({Color? borderClr, double? borderRadius}) {
    return isOutlineBorder
        ? OutlineInputBorder(
            borderSide: BorderSide(color: borderClr ?? hintClr),
            borderRadius: BorderRadius.circular(borderRadius ?? 9))
        : UnderlineInputBorder(
            borderSide: BorderSide(color: borderClr ?? hintClr));
  }
}
