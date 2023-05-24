import 'package:flutter/material.dart';

InputDecoration getInputDecoration(
    {required String hintText, required IconData iconData}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.all(20),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
    filled: true,
    fillColor: Colors.white,
    hintText: hintText,
    hintStyle: TextStyle(fontFamily: "Poppins", color: Colors.grey[350]),
    suffixIcon: Icon(
      iconData,
      color: Colors.black,
      size: 18,
    ),
  );
}

bool getStepActionStatus(
    int step, RoleType roleType, CARegistererType registererType) {
  switch (step) {
    case 0:
      return roleType == RoleType.none;
    case 1:
      return registererType == CARegistererType.none;
    default:
      return false;
  }
}

CARegistererType getRegistererTypeMapping(String type) {
  switch (type) {
    case "Sole proprietorship":
      return CARegistererType.sole;
    case "Sole proprietorship with registered firm":
      return CARegistererType.soleWithRegisteredFirm;
    default:
      return CARegistererType.partneredFirm;
  }
}

enum RoleType { ca, client, none }

enum CARegistererType { sole, soleWithRegisteredFirm, partneredFirm, none }
