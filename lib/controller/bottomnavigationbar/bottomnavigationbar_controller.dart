import 'package:get/get.dart';

abstract class BottomNavigationBarrController extends GetxController {
  onChange(int val);
}

class BottomNavigationBarrControllerImp extends BottomNavigationBarrController {
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
