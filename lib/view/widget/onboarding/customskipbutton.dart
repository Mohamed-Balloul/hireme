import 'package:hireme/controller/onboarding_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSkipButtonOnBoarding extends GetView<OnBoardingControllerImp> {
  const CustomSkipButtonOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.litegrey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              controller.skipToLets();
            },
            child: const Padding(
              padding: EdgeInsets.only(top: 25.6, left: 30, bottom: 20),
              child: Text("تخطي",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
