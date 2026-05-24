import 'dart:io';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/data/datasource/remote/auth/signup.dart';
import 'package:hireme/view/widget/auth/terms_conditions.dart';

abstract class SignUpController extends GetxController {
  signUp();
  goToSignIn();
  //
  showHidePassword();
  selectType(String type);
  onCheck(bool? value);
}

class SignUpControllerImp extends SignUpController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController password;

  bool isPasswordHidden = true;
  bool isChecked = false;

  late String selectedType = "طالب/خريج";
  //ربط
  StatusRequest statusRequest = StatusRequest.none;

  SignUpData signupData = SignUpData(Get.find());

  List data = [];
  //ربط

  @override
  goToSignIn() {
    Get.offNamed(AppRoute.login);
  }

  //ربط
  @override
  signUp() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      statusRequest = StatusRequest.loading;
      print("==============================-*-Controller $statusRequest ");
      update();
      // بعد ما ينجح الـ API call
      await Future.delayed(const Duration(seconds: 5)); // أضف هذا السطر
      // ثم انتقل لصفحة الـ

      var response = await signupData.postData(
        name.text,
        password.text,
        email.text,
        selectedType,
      );

      print("==============================* Controller $response ");
      print("==============================--Controller $statusRequest ");

      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        // Start backend
        if (response['status'] == "success") {
          // data.addAll(response['data']);
          Get.offNamed(AppRoute.verfiyCodeSignUp,
              arguments: {"email": email.text});
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
      Get.offNamed(AppRoute.verfiyCodeSignUp, arguments: {"email": email.text});
    } else {}
  }
  //ربط

  @override
  void onInit() {
    name = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  showHidePassword() {
    isPasswordHidden = isPasswordHidden == false ? true : false;
    update();
  }

  @override
  selectType(type) {
    selectedType = type;
    update();
  }

  @override
  onCheck(value) {
    isChecked = value!;
    update();
  }

  @override
  void goToTerms() {
    Get.to(() => const TermsAndConditions());
  }
}
