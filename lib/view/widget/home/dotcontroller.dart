import 'package:hireme/controller/home/homepage_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDotControllerHomePage extends StatelessWidget {
  const CustomDotControllerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageControllerImp>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(
            homeSliderList.length,
            (index) => AnimatedContainer(
              margin: const EdgeInsets.all(4),
              duration: const Duration(milliseconds: 700),
              width: controller.currentPage == index ? 7 : 7,
              height: controller.currentPage == index ? 7 : 7,
              decoration: BoxDecoration(
                // color: AppColor.primaryColor,
                color: controller.currentPage == index
                    ? AppColor.primaryColor
                    : const Color.fromARGB(255, 202, 202, 202),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
