import 'package:hireme/core/constant/routes.dart';
import 'package:get/get.dart';

abstract class LetsGetStartedController extends GetxController {
  goToSignUp();
  goToSignIn();
}

class LetsGetStartedControllerImp extends LetsGetStartedController {
  @override
  goToSignUp() {
    Get.offNamed(AppRoute.signUp);
  }

  @override
  goToSignIn() {
    Get.offNamed(AppRoute.login);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
