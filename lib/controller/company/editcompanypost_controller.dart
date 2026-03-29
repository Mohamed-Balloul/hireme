import 'package:hireme/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hireme/interfaces/dynamiclist_interface.dart';

abstract class EditCompanyPostController extends GetxController {
  signUp();
  goToSignIn();
  //
  showHidePassword();
  selectType(String type);
  onCvCheck(bool? value);
  onGitHubOrPortfolioCheck(bool? value);
  onPreSamplesCheck(bool? value);
  onSalaryCheck(bool? value);
  //
  addField(List<TextEditingController> list);
  // removeField(List<TextEditingController> list, int index);
}

class EditCompanyPostControllerImp extends EditCompanyPostController
    implements DynamicListInterface {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  //
  // 1. تعريف المتحكمات للنصوص البسيطة
  TextEditingController titleController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  // 2. تعريف قوائم المتحكمات للقوائم المتعددة (المهام، المتطلبات، الميزات)
  List<TextEditingController> dutiesControllers = [TextEditingController()];
  List<TextEditingController> requirementsControllers = [
    TextEditingController()
  ];
  List<TextEditingController> featuresControllers = [TextEditingController()];

  // 3. متغيرات للخيارات (Checkboxes)
  bool reqCVIsChecked = false;
  bool reqPortfolioIsChecked = false;
  bool reqSamplesIsChecked = false;
  bool reqSalaryIsChecked = false;
  //

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
    titleController = TextEditingController();
    detailsController = TextEditingController();
    for (var c in dutiesControllers) {
      c = TextEditingController();
    }
    for (var c in requirementsControllers) {
      c = TextEditingController();
    }
    for (var c in featuresControllers) {
      c = TextEditingController();
    }
    super.onInit();
  }

  @override
  void dispose() {
    titleController.dispose();
    detailsController.dispose();
    for (var c in dutiesControllers) {
      c.dispose();
    }
    for (var c in requirementsControllers) {
      c.dispose();
    }
    for (var c in featuresControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  showHidePassword() {}

  @override
  selectType(type) {}

  @override
  // دالة مساعدة لإضافة حقل جديد للقوائم
  void addField(list) {
    if (list.length < 5) {
      list.add(TextEditingController());
      update();
    }
  }

  @override
  // دالة مساعدة لحذف حقل من القوائم
  void removeField(list, index) {
    if (list.length > 1) {
      list[index].dispose(); // تنظيف الذاكرة
      list.removeAt(index);
      update();
    }
  }

  @override
  onCvCheck(value) {
    reqCVIsChecked = value!;
    update();
  }

  @override
  onGitHubOrPortfolioCheck(value) {
    reqPortfolioIsChecked = value!;
    update();
  }

  @override
  onPreSamplesCheck(value) {
    reqSamplesIsChecked = value!;
    update();
  }

  @override
  onSalaryCheck(value) {
    reqSalaryIsChecked = value!;
    update();
  }
}
