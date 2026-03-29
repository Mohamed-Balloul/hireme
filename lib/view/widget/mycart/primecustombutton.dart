import 'package:hireme/core/constant/color.dart';
import 'package:flutter/material.dart';

class PrimeCustomButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const PrimeCustomButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        // width
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 50),
        decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(50)),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
