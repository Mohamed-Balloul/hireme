import 'package:hireme/core/constant/routes.dart';
import 'package:get/get.dart';

abstract class PaymentMethodsController extends GetxController {
  goToPayment();
  goToPaymentSuccessfuly();
  onSelect(String? value);
}

class PaymentMethodsControllerImp extends PaymentMethodsController {
  String? paymentMethod;

  @override
  void onInit() {
    // pageController = PageController();
    super.onInit();
  }

  @override
  goToPayment() {
    Get.toNamed(AppRoute.paymentMethonds);
  }

  @override
  onSelect(value) {
    paymentMethod = value;
    update();
  }

  @override
  goToPaymentSuccessfuly() {
    Get.toNamed(AppRoute.paymentSuccessfuly);
  }
}
