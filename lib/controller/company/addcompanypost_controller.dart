import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/core/services/services.dart';
import 'package:hireme/data/datasource/remote/company/company.dart';
import 'package:hireme/interfaces/dynamiclist_interface.dart';

abstract class AddCompanyPostController extends GetxController {
  createCompanyPost();
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

class AddCompanyPostControllerImp extends AddCompanyPostController
    implements DynamicListInterface {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  //
  // 1. تعريف المتحكمات للنصوص البسيطة
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
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
  //ربط
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;

  CompanyData companyData = CompanyData(Get.find());

  // List data = [];
  //ربط

  @override
  goToSignIn() {
    Get.offNamed(AppRoute.login);
  }

  @override
  createCompanyPost() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      // --- تجهيز البيانات (Mapping) بناءً على توثيق Postman ---
      Map<String, dynamic> data = {
        "job_name": titleController.text,
        "additional_details": detailsController.text,
        "github_required": reqPortfolioIsChecked,
        "resume_required": reqCVIsChecked,
        "prev_work_required": reqSamplesIsChecked,
        "expected_salary_required": reqSalaryIsChecked,
      };

      // إضافة المتطلبات (req1, req2, ...)
      for (int i = 0; i < requirementsControllers.length; i++) {
        if (requirementsControllers[i].text.isNotEmpty) {
          data["req${i + 1}"] = requirementsControllers[i].text;
        }
      }

      // إضافة المهام (task1, task2, ...)
      for (int i = 0; i < dutiesControllers.length; i++) {
        if (dutiesControllers[i].text.isNotEmpty) {
          data["task${i + 1}"] = dutiesControllers[i].text;
        }
      }

      // إضافة الميزات (feature1, feature2, ...)
      for (int i = 0; i < featuresControllers.length; i++) {
        if (featuresControllers[i].text.isNotEmpty) {
          data["feature${i + 1}"] = featuresControllers[i].text;
        }
      }

      // إرسال الطلب للسيرفر
      String token = myServices.sharedPreferences.getString("token")!;
      var response = await companyData.createCompanyPost(data, token);

      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response["message"] == "Ad created successfully.") {
          // نجاح العملية
          // Get.back(); // العودة للخلف أو للهوم
          Get.snackbar("نجاح", "تم نشر الإعلان بنجاح",
              backgroundColor: Colors.green, colorText: Colors.white);

          // (اختياري) تحديث قائمة الإعلانات في صفحة الهوم فوراً
          // if (Get.isRegistered<CompanyHomeControllerImp>()) {
          //   // Get.find<CompanyHomeControllerImp>().getAds();
          // }
        } else {
          Get.defaultDialog(
              title: "تنبيه", middleText: "فشل في نشر الإعلان، حاول مجدداً");
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    }
  }

  @override
  void onInit() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
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
    descriptionController.dispose();
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
