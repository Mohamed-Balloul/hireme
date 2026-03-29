import 'package:get/get.dart';
import 'package:hireme/core/constant/routes.dart';

abstract class CustomerPostsDetailsController extends GetxController {
  goToAddCustomerPost();
  goToEditPost();
}

class CustomerPostsDetailsControllerImp extends CustomerPostsDetailsController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  goToAddCustomerPost() {
    Get.toNamed(AppRoute.addCustomerPost);
  }

  @override
  goToEditPost() {
    Get.toNamed(AppRoute.editCustomerPost);
  }
}
