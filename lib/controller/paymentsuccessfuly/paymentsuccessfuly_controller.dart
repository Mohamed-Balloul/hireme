import 'package:hireme/core/constant/routes.dart';
import 'package:get/get.dart';

abstract class PaymentSuccessfulyController extends GetxController {
  goToHome();
}

class PaymentSuccessfulyControllerImp extends PaymentSuccessfulyController {
  @override
  goToHome() {
    Get.offAllNamed(AppRoute.bottomNavigationBarPage);
    // Get.toName(AppRoute.myOrders);
  }
}
