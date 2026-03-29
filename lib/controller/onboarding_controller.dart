import 'package:hireme/core/constant/routes.dart';
import 'package:hireme/core/services/services.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class OnBoardingController extends GetxController {
  skipToLets();
  next();
  previous();
  onPageChanged(int index);
}

class OnBoardingControllerImp extends OnBoardingController {
  late PageController pageController;
  int currentPage = 0;

  MyServices myServices = Get.find();

  @override
  next() {
    currentPage++;
    if (currentPage > onBoardingList.length - 1) {
      myServices.sharedPreferences.setString("ishesawallonboardings", "1");
      Get.offNamed(AppRoute.letsGetStarted);
    } else {
      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  previous() {
    currentPage--;
    if (currentPage < 0) {
      currentPage = 0;
      Get.back();
    } else {
      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  onPageChanged(int index) {
    currentPage = index;
    update();
  }

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }

  @override
  skipToLets() {
    Get.offNamed(AppRoute.letsGetStarted);
  }
}
