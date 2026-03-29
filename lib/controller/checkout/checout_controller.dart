import 'package:hireme/core/constant/routes.dart';
import 'package:hireme/data/model/homegridflashsalesmodel.dart';
import 'package:get/get.dart';

abstract class CheckoutController extends GetxController {
  goToPayment();
}

class CheckoutControllerImp extends CheckoutController {
  @override
  void onInit() {
    // pageController = PageController();
    super.onInit();
  }

  @override
  goToPayment() {
    Get.toNamed(AppRoute.paymentMethonds);
  }
}
