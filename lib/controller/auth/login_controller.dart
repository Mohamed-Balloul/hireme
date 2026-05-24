import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/data/datasource/remote/auth/login.dart';
import 'package:hireme/data/datasource/remote/auth/signup.dart';
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

  //ربط
  StatusRequest statusRequest = StatusRequest.none;

  LoginData loginData = LoginData(Get.find());

  List data = [];
  //ربط

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
      //--
      statusRequest = StatusRequest.loading;
      print("==============================-*-Controller $statusRequest ");
      update();
      // بعد ما ينجح الـ API call
      await Future.delayed(const Duration(seconds: 5)); // أضف هذا السطر
      // ثم انتقل لصفحة الـ

      var response = await loginData.postData(
        email.text,
        password.text,
      );

      print("==============================* Controller $response ");
      print("==============================--Controller $statusRequest ");

      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        // Start backend
        if (response['status'] == "success") {
          // data.addAll(response['data']);
          // Get.offNamed(AppRoute.verfiyCodeSignUp,
          // arguments: {"email": email.text});
        } else {
          Get.defaultDialog(
            title: "warning",
            middleText: "email is already exist try using another one",
          );
          statusRequest = StatusRequest.failure;
        }
        // End
      } else {}
      // update();
      print("************************** *-*-* $statusRequest");

      // Future.delayed(Durations.extralong4);
      // Get.offNamed(AppRoute.verfiyCodeSignUp, arguments: {"email": email.text});

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
      //--
    } else {
      print("Not Valid");
    }
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
