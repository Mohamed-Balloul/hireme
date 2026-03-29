import 'package:get/get.dart';

abstract class StudentBottomNavigationBarrController extends GetxController {
  onChange(int val);
}

class StudentBottomNavigationBarrControllerImp
    extends StudentBottomNavigationBarrController {
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
