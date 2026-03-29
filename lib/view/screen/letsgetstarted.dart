import 'package:hireme/controller/letsgetstarted_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/view/widget/auth/custombuttonauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LetsGetStarted extends StatelessWidget {
  const LetsGetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    LetsGetStartedControllerImp controller =
        Get.put(LetsGetStartedControllerImp());
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(130),
                          border: Border.all(
                              color: AppColor.primaryColor, width: 3)),
                      width: 130,
                      height: 180,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(130),
                        child: Image.asset(
                          letsGetStartedList[0].imageone!,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(130),
                          border: Border.all(
                              color: AppColor.primaryColor, width: 3)),
                      width: 130,
                      height: 130,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(145),
                        child: Image.asset(
                          letsGetStartedList[0].imagetwo!,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(360),
                      border:
                          Border.all(color: AppColor.primaryColor, width: 3)),
                  width: 130,
                  height: 320,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(360),
                    child: Image.asset(
                      letsGetStartedList[0].imagethree!,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                  color: AppColor.greenblack,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Cairo',
                ),
                children: <TextSpan>[
                  TextSpan(
                      text:
                          "المكان الأفضل الذي يجمع بين\n الطلاب والشركات والعملاء"),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButtonAuth(
                text: "بدء",
                onPressed: () {
                  controller.goToSignUp();
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
