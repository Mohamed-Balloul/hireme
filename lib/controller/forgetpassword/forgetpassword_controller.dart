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

      // ثم انتقل لصفحة الـ

      var response = await checkEmailData.postData(
        email.text,
      );

      print("==============================* Controller $response ");
      print("==============================--Controller $statusRequest ");

      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        // Start backend
        if (response['data'] != null) {
          // data.addAll(response['data']);
          Get.offNamed(AppRoute.verfiyCode, arguments: {"email": email.text});
        } else {
          Get.defaultDialog(
            title: "خطأ",
            middleText:
                "البريد الالكتروني غير موجود، يرجى التحقق من البريد الالكتروني والمحاولة مجدداً.",
          );
          statusRequest = StatusRequest.none;
        }
        // End
      } else {
        // في حال فشل الاتصال بالإنترنت أو خطأ السيرفر العام
        Get.defaultDialog(
          title: "خطأ في الاتصال",
          middleText:
              "تعذر الاتصال بالخادم، يرجى التحقق من الإنترنت والمحاولة مجدداً.",
        );
        statusRequest = StatusRequest.none;
      }
      update();
      print("************************** *-*-* $statusRequest");
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
