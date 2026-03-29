import 'package:hireme/core/constant/routes.dart';
import 'package:get/get.dart';

abstract class VerfiyCodeSignUpController extends GetxController {
  // checkCode();
  goToSuccessSignUp();
  // backToForgetPassword();
}

class VerfiyCodeSignUpControllerImp extends VerfiyCodeSignUpController {
  late String verifyCode;

  @override
  goToSuccessSignUp() {
    Get.offNamed(AppRoute.successSignUp);
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
