import 'package:hireme/controller/onboarding_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CustomLeftButtonOnBoarding extends GetView<OnBoardingControllerImp> {
  const CustomLeftButtonOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.primaryColor),
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
      ),
      child: IconButton(
        onPressed: () {
          controller.previous();
        },
        icon: const Icon(
          Icons.arrow_back,
          color: AppColor.primaryColor,
        ),
      ),
    );
  }
}
