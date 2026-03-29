import 'package:hireme/controller/onboarding_controller.dart';
import 'package:hireme/view/widget/onboarding/customlefbutton.dart';
import 'package:hireme/view/widget/onboarding/customrightbutton.dart';
import 'package:hireme/view/widget/onboarding/customskipbutton.dart';
import 'package:hireme/view/widget/onboarding/customslider.dart';
import 'package:hireme/view/widget/onboarding/dotcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OnBoardingControllerImp());
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 0,
              child: CustomSkipButtonOnBoarding(),
            ),
            Expanded(
              flex: 4,
              child: CustomSliderOnBoarding(),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomLeftButtonOnBoarding(),
                  CustomDotControllerOnBoarding(),
                  CustomRightButtonOnBoarding(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
