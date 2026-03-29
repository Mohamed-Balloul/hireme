import 'package:hireme/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const CustomButton({
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
        // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
            // border: Border.all(
            //   color: const Color.fromARGB(255, 215, 214, 214),
            //   // color: AppColor.greenblack,
            //   width: 1,
            // ),
            // color: Colors.white,
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(6)),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 12,
              // color: AppColor.primaryColor,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
