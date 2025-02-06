import 'package:get/get.dart';

validateRequired(String labelText, String? value) =>
    GetUtils.isNullOrBlank(value) == true ? "$labelText is required" : null;

validateEmail(String? email) =>
    GetUtils.isEmail(email ?? "") ? null : "Email is not valid";

String? validatePhone(String? value) {
  if (value == null || value.isEmpty) {
    return "Mobile number is required";
  }

  String numericValue = value.replaceAll(RegExp(r'\D'), '');

  if (numericValue.length != 10) {
    return "Mobile number must have exactly 10 digits";
  }

  if (!numericValue.contains(RegExp(r'^[0-9]+$'))) {
    return "Mobile number can only contain numbers";
  }

  if (isAllDigitsSame(numericValue)) {
    return "Mobile number cannot consist of the same\n repeated digit";
  }

  return null;
}

bool isAllDigitsSame(String value) {
  return value.runes.length > 1 && value.runes.toSet().length == 1;
}
