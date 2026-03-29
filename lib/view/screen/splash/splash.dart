import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/splash/splash_controller.dart';
import 'package:hireme/core/constant/color.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashControllerImp());
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Column(
              // children: [
              // Image.asset("assets/images/logo.png"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ".Me",
                    style: TextStyle(
                        fontSize: 30,
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "hire",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColor.greenblack,
                    ),
                  ),
                ],
              ),
              // ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
