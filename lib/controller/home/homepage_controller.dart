import 'package:hireme/core/services/services.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/data/model/homegridflashsalesmodel.dart';
import 'package:hireme/view/screen/productdetails.dart/productdetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HomePageController extends GetxController {
  skipToLets();
  next();
  previous();
  onPageChanged(int index);
  onTapSelectCategoryFlashSale(int index);
  onTapSelectCategory(int index);
  //
  goToProductDetails(HomeGridFlashSalesModel homeGridFlashSalesModel);
}

class HomePageControllerImp extends HomePageController {
  late PageController pageController;
  int currentPage = 0;
  int currentFlashCategory = 0;
  int currentCategory = 0;

  MyServices myServices = Get.find();

  @override
  next() {
    currentPage++;
    if (currentPage > homeSliderList.length - 1) {
      // myServices.sharedPreferences.setString("ishesawallHomePages", "1");
      // Get.offNamed(AppRoute.letsGetStarted);
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
      // currentPage = 0;
      // Get.back();
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
    // Get.offNamed(AppRoute.letsGetStarted);
  }

  @override
  onTapSelectCategoryFlashSale(int index) {
    currentFlashCategory = index;
    update();
  }

  @override
  onTapSelectCategory(int index) {
    currentCategory = index;
    update();
  }

  @override
  goToProductDetails(homeGridFlashSalesModel) {
    Get.to(() => ProductDetails(
        homeGridFlashSalesModel:
            homeGridFlashSalesModel) /*arguments: {"homeGridFlashSalesModel": homeGridFlashSalesModel}*/);
  }
}
