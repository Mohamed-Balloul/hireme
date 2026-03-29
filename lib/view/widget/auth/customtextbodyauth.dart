import 'package:hireme/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomTextBodyAuth extends StatelessWidget {
  final String text;
  const CustomTextBodyAuth({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontSize: 14,
          // color: AppColor.grey,
          color: AppColor.primaryColor,
          fontWeight: FontWeight.bold),
    );
  }
}
