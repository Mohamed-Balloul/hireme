import 'package:get/get.dart';

abstract class ProfileController extends GetxController {
  completeYourProfile();

  select(String gender);
}

class ProfileControllerImp extends ProfileController {
  @override
  completeYourProfile() {}

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  select(String gender) {
    update();
  }
}
