import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/routes.dart';
import 'package:get/get.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/data/datasource/remote/forgetpassword/verifycodeforgetpassword.dart';

abstract class VerfiyCodeController extends GetxController {
  goToResetPassword(String verifyCode);
}

class VerfiyCodeControllerImp extends VerfiyCodeController {
  String? email;

  //ربط
  StatusRequest statusRequest = StatusRequest.none;
  VerifyCodeForgetPasswordData verifyCodeForgetPasswordData =
      VerifyCodeForgetPasswordData(Get.find());
  List data = [];
  //ربط

  @override
  goToResetPassword(verifyCode) async {
    // Get.offNamed(AppRoute.resetPassword);
    statusRequest = StatusRequest.loading;
    update();
    // بعد ما ينجح الـ API call
    await Future.delayed(const Duration(seconds: 5)); // أضف هذا السطر
// ثم انتقل لصفحة الـ verify
    var response =
        await verifyCodeForgetPasswordData.postData(email!, verifyCode);

    print("==============================* Controller $response ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        Get.offNamed(AppRoute.resetPassword, arguments: {"email": email});
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
    Get.offNamed(AppRoute.resetPassword, arguments: {"email": email});
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
