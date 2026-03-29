import 'package:hireme/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class ResetPasswordController extends GetxController {
  // resetPassword();
  goToSuccessResetPassword();
  // backToVerfiyCode();
  //
  showHidePassword();
  checkPasswords();
}

class ResetPasswordControllerImp extends ResetPasswordController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController password;
  late TextEditingController confirmPassword;

  bool isPasswordHidden = true;

  @override
  goToSuccessResetPassword() {
    var formData = formState.currentState;
    if (formData!.validate()) {
      if (password.text == confirmPassword.text) {
        Get.offNamed(AppRoute.successResetPassword);
      } else {
        update();
      }
    } else {
      update();
    }
  }

  // @override
  // backToVerfiyCode() {
  //   Get.back();
  // }

  // @override
  // resetPassword() {}

  @override
  void onInit() {
    password = TextEditingController();
    confirmPassword = TextEditingController();
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
