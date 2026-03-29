import 'package:get/get.dart';

abstract class MyWishListController extends GetxController {
  skipToLets();
  next();
  previous();
  onPageChanged(int index);
  onTapSelectCategoryMyWishList(int index);
  onTapSelectCategory(int index);
}

class MyWishListControllerImp extends MyWishListController {
  // late PageController pageController;
  // int currentPage = 0;
  int currentFlashCategory = 0;
  // int currentCategory = 0;

  // MyServices myServices = Get.find();

  @override
  next() {
    // currentPage++;
    // if (currentPage > homeSliderList.length - 1) {
    //   // myServices.sharedPreferences.setString("ishesawallMyWishLists", "1");
    //   // Get.offNamed(AppRoute.letsGetStarted);
    // } else {
    //   pageController.animateToPage(
    //     currentPage,
    //     duration: const Duration(milliseconds: 700),
    //     curve: Curves.easeInOut,
    //   );
    // }
  }

  @override
  previous() {
    // currentPage--;
    // if (currentPage < 0) {
    //   // currentPage = 0;
    //   // Get.back();
    // } else {
    //   pageController.animateToPage(
    //     currentPage,
    //     duration: const Duration(milliseconds: 700),
    //     curve: Curves.easeInOut,
    //   );
    // }
  }

  @override
  onPageChanged(int index) {
    // currentPage = index;
    // update();
  }

  @override
  void onInit() {
    // pageController = PageController();
    super.onInit();
  }

  @override
  skipToLets() {
    // Get.offNamed(AppRoute.letsGetStarted);
  }

  @override
  onTapSelectCategoryMyWishList(int index) {
    currentFlashCategory = index;
    update();
  }

  @override
  onTapSelectCategory(int index) {
    // currentCategory = index;
    // update();
  }
}
