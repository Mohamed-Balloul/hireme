import 'package:get/get.dart';
import 'package:hireme/core/constant/routes.dart';

abstract class FreelancerPostDetailsController extends GetxController {
  goToSendRequestToCustomer();
}

class FreelancerPostDetailsControllerImp
    extends FreelancerPostDetailsController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  goToSendRequestToCustomer() {
    Get.toNamed(AppRoute.sendRequestToCustomer);
  }
}
