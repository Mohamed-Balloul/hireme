import 'package:hireme/controller/auth/successsignup_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/view/widget/auth/custombuttonauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessSignUp extends StatelessWidget {
  const SuccessSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    SuccessSignUpControllerImp controller =
        Get.put(SuccessSignUpControllerImp());
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 100,
        ),
        child: Column(
          children: [
            const Center(
              child: Icon(
                Icons.check_circle_outline_outlined,
                color: AppColor.primaryColor,
                size: 150,
              ),
            ),
            const Text(
              "تهانينا!",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            const Text(
              "تم إنشاء حسابك بنجاح",
              style: TextStyle(
                fontSize: 14,
                color: AppColor.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
              ),
              child: CustomButtonAuth(
                text: "الذهاب الى تسجيل الدخول",
                onPressed: () {
                  controller.goToLogin();
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}
