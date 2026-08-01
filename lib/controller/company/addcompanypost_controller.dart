import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/core/services/services.dart';
import 'package:hireme/data/datasource/remote/company/company.dart';
import 'package:hireme/data/model/createadrequestmodel.dart';
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
  //ربط
  // createAndSendAd();
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
////--
//ربط
  // @override
  // createCompanyPost() async {
  //   var formData = formState.currentState;
  //   if (formData!.validate()) {
  //     statusRequest = StatusRequest.loading;
  //     print(
  //         "========createCompanyPost======================-*-Controller $statusRequest ");
  //     update();

  //     // --- تجهيز البيانات (Mapping) بناءً على توثيق Postman ---
  //     Map<String, dynamic> data = {
  //       "job_name": titleController.text,
  //       "additional_details": detailsController.text,
  //       "github_required": reqPortfolioIsChecked,
  //       "resume_required": reqCVIsChecked,
  //       "prev_work_required": reqSamplesIsChecked,
  //       "expected_salary_required": reqSalaryIsChecked,
  //     };

  //     // إضافة المتطلبات (req1, req2, ...)
  //     for (int i = 0; i < requirementsControllers.length; i++) {
  //       if (requirementsControllers[i].text.isNotEmpty) {
  //         data["req${i + 1}"] = requirementsControllers[i].text;
  //       }
  //     }

  //     // إضافة المهام (task1, task2, ...)
  //     for (int i = 0; i < dutiesControllers.length; i++) {
  //       if (dutiesControllers[i].text.isNotEmpty) {
  //         data["task${i + 1}"] = dutiesControllers[i].text;
  //       }
  //     }

  //     // إضافة الميزات (feature1, feature2, ...)
  //     for (int i = 0; i < featuresControllers.length; i++) {
  //       if (featuresControllers[i].text.isNotEmpty) {
  //         data["feature${i + 1}"] = featuresControllers[i].text;
  //       }
  //     }

  //     // إرسال الطلب للسيرفر
  //     String token = myServices.sharedPreferences.getString("token")!;
  //     var response = await companyData.createCompanyPost(data, token);

  //     statusRequest = handlingData(response);

  //     if (StatusRequest.success == statusRequest) {
  //       if (response["message"] == "Ad created successfully.") {
  //         // نجاح العملية
  //         // Get.back(); // العودة للخلف أو للهوم
  //         Get.snackbar("نجاح", "تم نشر الإعلان بنجاح",
  //             backgroundColor: Colors.green, colorText: Colors.white);

  //         // (اختياري) تحديث قائمة الإعلانات في صفحة الهوم فوراً
  //         // if (Get.isRegistered<CompanyHomeControllerImp>()) {
  //         //   // Get.find<CompanyHomeControllerImp>().getAds();
  //         // }
  //       } else {
  //         Get.defaultDialog(
  //             title: "تنبيه", middleText: "فشل في نشر الإعلان، حاول مجدداً");
  //         statusRequest = StatusRequest.failure;
  //       }
  //     }
  //     update();
  //   } else {}
  // }
  // تحديث دالة createCompanyPost بداخل كلاس AddCompanyPostControllerImp:
// استبدل كود دالة createCompanyPost بداخل كلاس AddCompanyPostControllerImp بالكود المحدث التالي:

  @override
  createCompanyPost() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      statusRequest = StatusRequest.loading;
      print(
          "========createCompanyPost======================-*-Controller $statusRequest ");
      update();

      // 1. استخلاص المجموعات النصية وتصفيتها من الحقول الفارغة
      List<String> requirements = requirementsControllers
          .map((c) => c.text.trim())
          .where((text) => text.isNotEmpty)
          .toList();

      List<String> duties = dutiesControllers
          .map((c) => c.text.trim())
          .where((text) => text.isNotEmpty)
          .toList();

      List<String> features = featuresControllers
          .map((c) => c.text.trim())
          .where((text) => text.isNotEmpty)
          .toList();

      // 2. إلغاء الدمج السابق وتجهيز الحقول منفصلة تماماً لتطابق الباك-إند
      String finalDescription = descriptionController.text.trim();
      String finalDetails = detailsController.text.trim();

      // 3. بناء الموديل المحدث والمنظم
      CreateAdRequestModel requestModel = CreateAdRequestModel(
        jobName: titleController.text.trim(),
        description:
            finalDescription.isEmpty ? "لا يوجد وصف متوفر" : finalDescription,
        additionalDetails:
            finalDetails.isEmpty ? "لا توجد تفاصيل إضافية" : finalDetails,
        requirements: requirements,
        duties: duties,
        features: features,
        githubRequired: reqPortfolioIsChecked,
        resumeRequired: reqCVIsChecked,
        prevWorkRequired: reqSamplesIsChecked,
        expectedSalaryRequired: reqSalaryIsChecked,
      );

      // 4. إرسال الطلب للسيرفر بالخريطة الجديدة المحدثة
      String token = myServices.sharedPreferences.getString("token")!;
      var response =
          await companyData.createCompanyPost(requestModel.toJson(), token);
      print(
          "======createCompanyPost========================* Controller $response ");
      print(
          "=====createCompanyPost=========================--Controller $statusRequest ");

      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response["message"] == "Ad created successfully.") {
          Get.snackbar("نجاح", "تم نشر الإعلان بنجاح",
              backgroundColor: Colors.green, colorText: Colors.white);
          _clearAllFields(); // تفريغ الحقول والرامات بأمان
        } else {
          Get.defaultDialog(
              title: "تنبيه", middleText: "فشل في نشر الإعلان، حاول مجدداً");
          statusRequest = StatusRequest.failure;
        }
      }
      update();
      print("*****createCompanyPost********************* *-*-* $statusRequest");
    } else {}
  }
  // @override
  // createCompanyPost() async {
  //   var formData = formState.currentState;
  //   if (formData!.validate()) {
  //     statusRequest = StatusRequest.loading;
  //     print(
  //         "========createCompanyPost======================-*-Controller $statusRequest ");
  //     update();

  //     // 1. استخلاص المجموعات النصية وتصفيتها من الحقول الفارغة
  //     List<String> requirements = requirementsControllers
  //         .map((c) => c.text.trim())
  //         .where((text) => text.isNotEmpty)
  //         .toList();

  //     List<String> duties = dutiesControllers
  //         .map((c) => c.text.trim())
  //         .where((text) => text.isNotEmpty)
  //         .toList();

  //     List<String> features = featuresControllers
  //         .map((c) => c.text.trim())
  //         .where((text) => text.isNotEmpty)
  //         .toList();

  //     // 2. معالجة مشكلة حقل الوصف غير المدعوم بالبوستمان (تم دمج الوصف مع التفاصيل الإضافية)
  //     String finalDetails = "";
  //     if (descriptionController.text.trim().isNotEmpty) {
  //       finalDetails += "الوصف: ${descriptionController.text.trim()}\n\n";
  //     }
  //     finalDetails += detailsController.text.trim();

  //     // 3. بناء الموديل الاحترافي
  //     CreateAdRequestModel requestModel = CreateAdRequestModel(
  //       jobName: titleController.text.trim(),
  //       additionalDetails:
  //           finalDetails.isEmpty ? "لا توجد تفاصيل إضافية" : finalDetails,
  //       requirements: requirements,
  //       duties: duties,
  //       features: features,
  //       githubRequired: reqPortfolioIsChecked,
  //       resumeRequired: reqCVIsChecked,
  //       prevWorkRequired: reqSamplesIsChecked,
  //       expectedSalaryRequired: reqSalaryIsChecked,
  //     );

  //     // 4. إرسال الطلب للسيرفر باستخدام الـ Json المجهز من الموديل
  //     String token = myServices.sharedPreferences.getString("token")!;
  //     var response =
  //         await companyData.createCompanyPost(requestModel.toJson(), token);
  //     print(
  //         "======createCompanyPost========================* Controller $response ");
  //     print(
  //         "=====createCompanyPost=========================--Controller $statusRequest ");

  //     statusRequest = handlingData(response);

  //     if (StatusRequest.success == statusRequest) {
  //       if (response["message"] == "Ad created successfully.") {
  //         Get.snackbar("نجاح", "تم نشر الإعلان بنجاح",
  //             backgroundColor: Colors.green, colorText: Colors.white);
  //         _clearAllFields(); // دالة فرعية لتفريغ الحقول بعد النجاح
  //       } else {
  //         Get.defaultDialog(
  //             title: "تنبيه", middleText: "فشل في نشر الإعلان، حاول مجدداً");
  //         statusRequest = StatusRequest.failure;
  //       }
  //     }
  //     update();
  //     print("*****createCompanyPost********************* *-*-* $statusRequest");
  //   } else {}
  // }

  // دالة لتفريغ البيانات بعد نجاح العملية لتجهيز الصفحة لإعلان جديد
  // void _clearAllFields() {
  //   titleController.clear();
  //   descriptionController.clear();
  //   detailsController.clear();
  //   dutiesControllers = [TextEditingController()];
  //   requirementsControllers = [TextEditingController()];
  //   featuresControllers = [TextEditingController()];
  //   reqCVIsChecked = false;
  //   reqPortfolioIsChecked = false;
  //   reqSamplesIsChecked = false;
  //   reqSalaryIsChecked = false;
  //   update();
  // }
  // دالة تفريغ البيانات الآمنة برمجياً لتفادي تسريب الذاكرة
  void _clearAllFields() {
    titleController.clear();
    descriptionController.clear();
    detailsController.clear();

    // 1. تنظيف الذاكرة من المتحكمات القديمة قبل حذفها
    for (var c in dutiesControllers) {
      c.dispose();
    }
    for (var c in requirementsControllers) {
      c.dispose();
    }
    for (var c in featuresControllers) {
      c.dispose();
    }

    // 2. إعادة تهيئة القوائم بمتحكم واحد نظيف وجديد
    dutiesControllers = [TextEditingController()];
    requirementsControllers = [TextEditingController()];
    featuresControllers = [TextEditingController()];

    reqCVIsChecked = false;
    reqPortfolioIsChecked = false;
    reqSamplesIsChecked = false;
    reqSalaryIsChecked = false;

    // 3. إعادة تعيين حالة الطلب للوضع الافتراضي
    statusRequest = StatusRequest.none;

    update();
  }

  @override
  void onInit() {
    // إزالة الحلقات التكرارية غير الصحيحة والاكتفاء بإنشاء كائنات النصوص الأساسية
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    detailsController = TextEditingController();
    super.onInit();
  }

  // @override
  // void onInit() {
  //   titleController = TextEditingController();
  //   descriptionController = TextEditingController();
  //   detailsController = TextEditingController();
  //   for (var c in dutiesControllers) {
  //     c = TextEditingController();
  //   }
  //   for (var c in requirementsControllers) {
  //     c = TextEditingController();
  //   }
  //   for (var c in featuresControllers) {
  //     c = TextEditingController();
  //   }
  //   super.onInit();
  // }

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
