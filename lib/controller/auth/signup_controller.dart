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
  // دالة مساعدة لتحويل النوع إلى اللغة الإنجليزية المتوافقة مع الباك اند
  mapRoleToEnglish(String arabicRole);
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

  @override
  String mapRoleToEnglish(arabicRole) {
    switch (arabicRole) {
      case "طالب/خريج":
        return "student";
      case "شركة":
        return "company";
      case "عميل":
        return "customer";
      default:
        return "student"; // القيمة الافتراضية في حال عدم المطابقة
    }
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
      // await Future.delayed(const Duration(seconds: 5)); // أضف هذا السطر
      // ثم انتقل لصفحة الـ

      var response = await signupData.postData(
        name.text,
        password.text,
        email.text,
        mapRoleToEnglish(selectedType), // تعديل هنا لإرسال القيمة الإنجليزية
      );

      print("==============================* Controller $response ");
      print("==============================--Controller $statusRequest ");

      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        // Start backend
        // if (response['status'] == "success") {
        if (response['data'] != null) {
          // data.addAll(response['data']);
          Get.offNamed(AppRoute.verfiyCodeSignUp,
              arguments: {"email": email.text});
        } else {
          // في حال عدم وجود data

          Get.defaultDialog(
            title: "تنبيه",
            middleText: "اسم المستخدم او البريد الإلكتروني مستخدم بالفعل!",
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
      update(); // استدعاء التحديث هنا مهم جداً لإخفاء شاشة التحميل وإعادة عرض النموذج

      print("************************** *-*-* $statusRequest");
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
