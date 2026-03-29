import 'package:hireme/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/view/widget/auth/mockauthservice.dart';
import 'package:hireme/view/widget/auth/usertype.dart';

abstract class LoginController extends GetxController {
  login();
  goToSignUp();
  goToForgetPassword();
  //
  showHidePassword();
}

class LoginControllerImp extends LoginController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  late TextEditingController email;
  late TextEditingController password;

  bool isPasswordHidden = true;

  @override
  goToSignUp() {
    Get.offNamed(AppRoute.signUp);
  }

  @override
  goToForgetPassword() {
    Get.offNamed(AppRoute.forgetPassword);
  }

  @override
  login() async {
    var formdata = formState.currentState;
    if (formdata!.validate()) {
      // 1. استدعاء الخدمة الوهمية
      UserType role = await MockAuthService().login(email.text, password.text);

      // 2. التوجيه بناءً على النتيجة
      switch (role) {
        case UserType.student:
          Get.offNamed(AppRoute.studentBottomNavigationBarPage);
          break;
        case UserType.company:
          Get.offNamed(AppRoute.companyBottomNavigationBarPage);
          break;
        case UserType.customer:
          Get.offNamed(AppRoute.customerBottomNavigationBarPage);
          break;
        default:
          // إظهار رسالة خطأ
          break;
      }
    } else {}
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  showHidePassword() {
    isPasswordHidden = isPasswordHidden == false ? true : false;
    update();
  }
}
