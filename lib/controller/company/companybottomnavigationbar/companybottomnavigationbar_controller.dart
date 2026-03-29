import 'package:get/get.dart';

abstract class CompanyBottomNavigationBarrController extends GetxController {
  onChange(int val);
}

class CompanyBottomNavigationBarrControllerImp
    extends CompanyBottomNavigationBarrController {
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
