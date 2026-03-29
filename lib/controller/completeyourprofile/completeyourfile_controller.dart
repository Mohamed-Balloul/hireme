// import 'package:ecoapp/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CompleteYourProfileController extends GetxController {
  completeYourProfile();

  select(String gender);
}

class CompleteYourProfileControllerImp extends CompleteYourProfileController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  late TextEditingController phoneNumber;

  late String selectedGender = "Male";

  @override
  completeYourProfile() {
    var formdata = formState.currentState;
    if (formdata!.validate()) {
      // Get.offNamed();
    } else {}
  }

  @override
  void onInit() {
    phoneNumber = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    phoneNumber.dispose();
    super.dispose();
  }

  @override
  select(String gender) {
    selectedGender = gender;
    update();
  }
}
