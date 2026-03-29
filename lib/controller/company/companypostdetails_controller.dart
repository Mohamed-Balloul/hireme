import 'package:get/get.dart';
import 'package:hireme/core/constant/routes.dart';

abstract class CompanyPostsDetailsController extends GetxController {
  goToAddCompanyPost();
  goToEditPost();
}

class CompanyPostsDetailsControllerImp extends CompanyPostsDetailsController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  goToAddCompanyPost() {
    Get.toNamed(AppRoute.addCompanyPost);
  }

  @override
  goToEditPost() {
    Get.toNamed(AppRoute.editCompanyPost);
  }
}
