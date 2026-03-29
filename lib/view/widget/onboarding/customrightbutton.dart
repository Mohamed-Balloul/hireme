import 'package:hireme/controller/onboarding_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomRightButtonOnBoarding extends GetView<OnBoardingControllerImp> {
  const CustomRightButtonOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        border: Border.all(color: AppColor.primaryColor),
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
      ),
      child: IconButton(
          onPressed: () {
            controller.next();
          },
          icon: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          )),
    );
  }
}
