import 'package:flutter/material.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  const ProgressIndicatorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(color: Colors.lightBlueAccent,);
  }
}