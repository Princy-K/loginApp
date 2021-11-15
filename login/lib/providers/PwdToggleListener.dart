import 'package:flutter/material.dart';

class PwdToggleListener extends ChangeNotifier {
  bool obscureText = true,  isEnable = false;
  IconData iconData = Icons.visibility_outlined;

  void toggle() {
    obscureText = !obscureText;
    iconData = obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    notifyListeners();
  }

  void buttonEnable(bool isButtonEnable) {
    isEnable = isButtonEnable;
    notifyListeners();
  }



}
