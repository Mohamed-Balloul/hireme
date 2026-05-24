import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/routes.dart';
import 'package:get/get.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/data/datasource/remote/auth/verifycodesignup.dart';

abstract class VerfiyCodeSignUpController extends GetxController {
  goToSuccessSignUp(String verifyCode);
}

class VerfiyCodeSignUpControllerImp extends VerfiyCodeSignUpController {
  VerifyCodeSignUpData verifyCodeSignUpData = VerifyCodeSignUpData(Get.find());

  String? email;
  //ربط
  StatusRequest statusRequest = StatusRequest.none;

  List data = [];
  //ربط

  @override
  goToSuccessSignUp(verifyCode) async {
    statusRequest = StatusRequest.loading;
    update();
    // بعد ما ينجح الـ API call
    await Future.delayed(const Duration(seconds: 5)); // أضف هذا السطر
// ثم انتقل لصفحة الـ verify
    var response = await verifyCodeSignUpData.postData(email!, verifyCode);

    print("==============================* Controller $response ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        Get.offNamed(AppRoute.successSignUp);
      } else {
        Get.defaultDialog(
          title: "warning",
          middleText: "Verify Code Is Not Correct",
        );
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    // update();
    print("************************** ");
    Get.offNamed(AppRoute.successSignUp);
  }

  @override
  void onInit() {
    email = Get.arguments['email'];
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
