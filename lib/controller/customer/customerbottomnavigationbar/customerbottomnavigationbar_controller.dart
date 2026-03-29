import 'package:get/get.dart';

abstract class CustomerBottomNavigationBarrController extends GetxController {
  onChange(int val);
}

class CustomerBottomNavigationBarrControllerImp
    extends CustomerBottomNavigationBarrController {
  int selectedIndex = 0;

  @override
  void onInit() {
    // pageController = PageController();
    super.onInit();
  }

  // add product to cart
  @override
  onChange(val) {
    selectedIndex = val;
    update();
  }
}
