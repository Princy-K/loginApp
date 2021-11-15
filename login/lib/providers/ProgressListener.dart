import 'package:flutter/material.dart';

class ProgressListener extends ChangeNotifier{

  bool isLoading = false;

  void isProgressLoading(bool isDismiss) {
    isLoading = isDismiss;
    notifyListeners();
  }

}
