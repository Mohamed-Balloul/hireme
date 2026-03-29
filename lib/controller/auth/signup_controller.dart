import 'package:hireme/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
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

  @override
  goToSignIn() {
    Get.offNamed(AppRoute.login);
  }

  @override
  signUp() {
    var formData = formState.currentState;
    if (formData!.validate()) {
      Get.offNamed(AppRoute.verfiyCodeSignUp);
    } else {}
  }

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
