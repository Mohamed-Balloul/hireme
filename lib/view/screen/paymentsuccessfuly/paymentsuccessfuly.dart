import 'package:hireme/controller/paymentsuccessfuly/paymentsuccessfuly_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/view/widget/auth/custombuttonauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentSuccessfuly extends StatelessWidget {
  const PaymentSuccessfuly({super.key});

  @override
  Widget build(BuildContext context) {
    PaymentSuccessfulyControllerImp controller =
        Get.put(PaymentSuccessfulyControllerImp());
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
              "Payment Successful!",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            const Text(
              "Thank You For Your Purchase.",
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
                text: "Go back to Main Page",
                onPressed: () {
                  controller.goToHome();
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}
