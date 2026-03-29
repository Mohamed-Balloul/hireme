import 'dart:async';

import 'package:get/get.dart';
import 'package:hireme/core/constant/routes.dart';

abstract class SplashController extends GetxController {}

class SplashControllerImp extends SplashController {
  @override
  void onInit() {
    super.onInit();
    Timer(
      const Duration(seconds: 3),
      () {
        Get.offNamed(AppRoute.onBoarding);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
