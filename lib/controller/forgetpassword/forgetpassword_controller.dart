import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/data/datasource/remote/forgetpassword/checkemail.dart';

abstract class ForgetPasswordController extends GetxController {
  checkEmail();
  // goToVerfiyCode();
  backToSignIn();
}

class ForgetPasswordControllerImp extends ForgetPasswordController {
  //ربط
  StatusRequest statusRequest = StatusRequest.none;
  CheckEmailData checkEmailData = CheckEmailData(Get.find());
  //ربط

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController email;

  @override
  checkEmail() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      // Get.offNamed(AppRoute.verfiyCode);
      // بعد ما ينجح الـ API call
      // await Future.delayed(const Duration(seconds: 5)); // أضف هذا السطر
      // ثم انتقل لصفحة الـ verify
      statusRequest = StatusRequest.loading;
      print("==============================-*-Controller $statusRequest ");
      update();
      // بعد ما ينجح الـ API call
      await Future.delayed(const Duration(seconds: 5)); // أضف هذا السطر
      // ثم انتقل لصفحة الـ

      var response = await checkEmailData.postData(
        email.text,
      );

      print("==============================* Controller $response ");
      print("==============================--Controller $statusRequest ");

      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        // Start backend
        if (response['status'] == "success") {
          // data.addAll(response['data']);
          Get.offNamed(AppRoute.verfiyCode, arguments: {"email": email.text});
        } else {
          Get.defaultDialog(
            title: "warning",
            middleText: "Email Not Found",
          );
          statusRequest = StatusRequest.failure;
        }
        // End
      } else {}
      // update();
      print("************************** *-*-* $statusRequest");

      // Future.delayed(Durations.extralong4);
      Get.offNamed(AppRoute.verfiyCode, arguments: {"email": email.text});
    } else {}
  }

  @override
  backToSignIn() {
    Get.offNamed(AppRoute.login);
  }

  // @override
  // checkEmail() {}

  @override
  void onInit() {
    email = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }
}
