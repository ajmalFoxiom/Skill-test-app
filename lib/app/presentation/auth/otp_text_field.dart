import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/widgets/hexColorCode.dart';

class OTPInputFields extends StatefulWidget {
  final Function(String) onCompleted;
  final int length;
  final bool isVlidation;

  const OTPInputFields(
      {super.key,
      required this.onCompleted,
      this.length = 4,
      this.isVlidation = false});

  @override
  State<OTPInputFields> createState() => _OTPInputFieldsState();
}

class _OTPInputFieldsState extends State<OTPInputFields> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.length,
      (index) => TextEditingController(),
    );
    _focusNodes = List.generate(
      widget.length,
      (index) => FocusNode(),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }


  // ignore: deprecated_member_use
  void _handleKeyPress(RawKeyEvent event, int index) {
    // ignore: deprecated_member_use
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.backspace) {
     
        if (_controllers[index].text.isEmpty && index > 0) {
          _focusNodes[index - 1].requestFocus();
          _controllers[index - 1].clear();
        } else {
        
          _controllers[index].clear();
        }
      }
    }
  }

  void _onChanged(String value, int index) {
    if (value.length == 1) {
    
      if (index < widget.length - 1) {
        _focusNodes[index + 1].requestFocus();
      }
    }


    if (_controllers.every((controller) => controller.text.isNotEmpty)) {
      String otp = _controllers.map((controller) => controller.text).join();
      widget.onCompleted(otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        widget.length,
        (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 6.w),
          width: 75.w,
          height: 58.h,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.isVlidation ? Colors.red : Colors.grey[300]!,
              width: 1,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                HexColor("#F6F6F6"),
                Colors.white,
              ],
            ),
          ),
          // ignore: deprecated_member_use
          child: RawKeyboardListener(
            focusNode: FocusNode(),
            onKey: (event) => _handleKeyPress(event, index),
            child: TextFormField(
              autofocus: true,
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.transparent,
              ),
              onChanged: (value) => _onChanged(value, index),
            ),
          ),
        ),
      ),
    );
  }
}
