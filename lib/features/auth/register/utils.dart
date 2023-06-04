import 'package:find_my_ca/shared/enums.dart';

String? membershipValidator(CARegistererType type, String? value) {
  if (type == CARegistererType.sole && value != null && value.length != 6) {
    return "Please enter 6 digits membership number";
  }
  if ((type == CARegistererType.soleWithRegisteredFirm ||
          type == CARegistererType.partneredFirm) &&
      value != null &&
      value.length != 7) {
    return "Please enter 7 digits membership number";
  }
  return null;
}

String? upiValidator(String? val) {
  if (val == null || val.isEmpty) {
    return "Please enter UPI ID as its necessary for payment purposes";
  }
  RegExp regExp = RegExp(r'[a-zA-Z0-9.\-_]{2,256}@[a-zA-Z]{2,64}');
  if (!regExp.hasMatch(val)) return "Please enter valid UPI ID";
  return null;
}

String? phoneValidator(String? val) {
  if (val == null || val.isEmpty) {
    return "Please enter phone number";
  }
  RegExp regExp = RegExp(r'[0-9]{10}');
  if (!regExp.hasMatch(val)) {
    return "Please enter a valid 10 digit phone number ";
  }
  return null;
}

String? ageValidator(String? val) {
  if (val == null || val.isEmpty) {
    return "Please enter your age";
  }
  RegExp regExp = RegExp(r'^[0-9]{2}$');
  if (!regExp.hasMatch(val)) {
    return "Please enter a valid age";
  }
  return null;
}

String? passwordValidator(String? val) {
  if (val == null || val.isEmpty) {
    return "Please enter your password";
  }
  RegExp regExp = RegExp(r'^().{8,}$');
  if (!regExp.hasMatch(val)) {
    return "Password must be minimum 8 characters";
  }
  return null;
}

String? emailValidator(String? val) {
  if (val == null || val.isEmpty) {
    return "Please enter email";
  }
  RegExp regExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!regExp.hasMatch(val)) {
    return "Please enter a valid email address";
  }
  return null;
}
