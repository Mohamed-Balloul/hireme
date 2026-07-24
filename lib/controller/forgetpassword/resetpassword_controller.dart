import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/data/datasource/remote/forgetpassword/resetpassword.dart';

abstract class ResetPasswordController extends GetxController {
  goToSuccessResetPassword();

  //
  showHidePassword();
  checkPasswords();
}

class ResetPasswordControllerImp extends ResetPasswordController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController password;
  late TextEditingController confirmPassword;

  bool isPasswordHidden = true;

  //ربط
  StatusRequest statusRequest = StatusRequest.none;

  ResetPasswordData resetPassword = ResetPasswordData(Get.find());

  List data = [];

  String? email;
  String? token; // متغير جديد لحفظ التوكن
  //ربط

  @override
  goToSuccessResetPassword() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      if (password.text == confirmPassword.text) {
        // Get.offNamed(AppRoute.successResetPassword);
        statusRequest = StatusRequest.loading;
        print("==============================-*-Controller $statusRequest ");
        update();
        // بعد ما ينجح الـ API call
        // ثم انتقل لصفحة الـ

        var response = await resetPassword.postData(
          email!,
          password.text,
          // token!, // تأكد من إرسال التوكن مع الطلب
        );

        print("==============================* Controller $response ");
        print("==============================--Controller $statusRequest ");

        statusRequest = handlingData(response);

        if (StatusRequest.success == statusRequest) {
          // Start backend
          if (response['message'] != null) {
            // data.addAll(response['data']);
            Get.offNamed(AppRoute.successResetPassword,
                arguments: {"email": email});
          } else {
            Get.defaultDialog(
              title: "warning",
              middleText: "Try Again",
            );
            statusRequest = StatusRequest.none;
          }
          // End
        } else {
          // في حال فشل الاتصال بالسيرفر أو انقطاع الإنترنت
          Get.defaultDialog(
            title: "خطأ",
            middleText:
                "حدث خطأ أثناء الاتصال بالخادم،تحقق من اتصالك وأعد المحاولة.",
          );
          statusRequest = StatusRequest.none;
        }
        update();
        print("************************** *-*-* $statusRequest");
      } else {
        update();
      }
    } else {
      update();
      return Get.defaultDialog(
          title: "warning", middleText: "Password Not Match");
    }
  }

  @override
  void onInit() {
    password = TextEditingController();
    confirmPassword = TextEditingController();
    email = Get.arguments['email'];
    token = Get.arguments['token']; // تأكد من إرساله من واجهة VerifyOTP
    super.onInit();
  }

  @override
  void dispose() {
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  showHidePassword() {
    isPasswordHidden = isPasswordHidden == false ? true : false;
    update();
  }

  @override
  checkPasswords() {
    if (password.text == confirmPassword.text) {
      return Container();
    } else {
      return const Text(
        "كلمتا المرور غير متطابقتين",
        style: TextStyle(color: Colors.red),
      );
    }
  }
}
