import 'package:hireme/core/constant/routes.dart';
import 'package:hireme/core/localization/changelocal.dart';
import 'package:hireme/view/widget/auth/custombuttonauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Language extends GetView<LocaleController> {
  const Language({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "1".tr,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
              ),
              child: CustomButtonAuth(
                text: "Ar",
                onPressed: () {
                  controller.changeLang("ar");
                  Get.offNamed(AppRoute.onBoarding);
                },
              ),
            ),
            CustomButtonAuth(
              text: "En",
              onPressed: () {
                controller.changeLang("en");
                Get.offNamed(AppRoute.onBoarding);
              },
            ),
          ],
        ),
      ),
    );
  }
}
