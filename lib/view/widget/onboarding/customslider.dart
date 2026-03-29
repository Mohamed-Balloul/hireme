import 'package:hireme/controller/onboarding_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSliderOnBoarding extends GetView<OnBoardingControllerImp> {
  const CustomSliderOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: AppColor.litegrey,
      child: PageView(
        controller: controller.pageController,
        onPageChanged: (value) {
          // print(value);
          controller.onPageChanged(value);
        },
        children: [
          //-------------------- 1 -----------------
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  child: Image.asset(
                    onBoardingList[0].image!,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  width: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          style: TextStyle(
                            color: AppColor.greenblack,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Cairo',
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: "تأمين",
                            ),
                            TextSpan(
                              text: " فرص ",
                              style: TextStyle(
                                color: AppColor.primaryColor,
                              ),
                            ),
                            TextSpan(
                              text: "العمل",
                            ),
                          ],
                        ),
                      ),
                      Text(
                        onBoardingList[0].body!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColor.grey,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          //---------------------------2--------------
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  child: Image.asset(
                    onBoardingList[1].image!,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  width: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          style: TextStyle(
                            color: AppColor.greenblack,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Cairo',
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: "ربط",
                            ),
                            TextSpan(
                              text: " المهارات ",
                              style: TextStyle(color: AppColor.primaryColor),
                            ),
                            TextSpan(
                              text: "بسوق العمل",
                            ),
                          ],
                        ),
                      ),
                      Text(
                        onBoardingList[1].body!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColor.grey,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          //------------------------- 3   --------
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  child: Image.asset(
                    onBoardingList[2].image!,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  width: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          style: TextStyle(
                            color: AppColor.greenblack,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Cairo',
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: "تقديم",
                            ),
                            TextSpan(
                              text: " خدمات ",
                              style: TextStyle(color: AppColor.primaryColor),
                            ),
                            TextSpan(
                              text: "العمل الحر",
                            ),
                          ],
                        ),
                      ),
                      Text(
                        onBoardingList[2].body!,
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: AppColor.grey, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
