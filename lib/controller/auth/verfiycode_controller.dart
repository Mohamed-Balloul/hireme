import 'package:hireme/core/constant/routes.dart';
import 'package:get/get.dart';

abstract class VerfiyCodeController extends GetxController {
  // checkCode();
  goToResetPassword();
  // backToForgetPassword();
}

class VerfiyCodeControllerImp extends VerfiyCodeController {
  late String verifyCode;

  @override
  goToResetPassword() {
    Get.offNamed(AppRoute.resetPassword);
  }

  // @override
  // backToForgetPassword() {
  //   Get.back();
  // }

  // @override
  // checkCode() {}

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
