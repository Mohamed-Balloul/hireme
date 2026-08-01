import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/company/companybottomnavigationbar/companybottomnavigationbar_controller.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/core/services/services.dart';
import 'package:hireme/data/datasource/remote/company/company.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/data/model/companyprofilemodel.dart';
import 'package:intl/intl.dart'; // ستحتاج لإضافة حزمة intl في pubspec.yaml لتنسيق التاريخ
import 'package:image_picker/image_picker.dart';

abstract class EditCompanyProfileController extends GetxController {
  // pickExperienceLogo();
  addSkill();
  removeSkill(int index);
  //ربط
  saveAll();
  //ربط
}

// ملاحظة: تأكد من إضافة هذا الملف في المسار الصحيح
class EditCompanyProfileControllerImp extends EditCompanyProfileController {
  //ربط
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  CompanyBottomNavigationBarrControllerImp controller =
      Get.find<CompanyBottomNavigationBarrControllerImp>();

  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;

  CompanyData companyData = CompanyData(Get.find());

  //ربط

  // نقوم بتعريف TextControllers لكل حقل لسهولة التحكم
  late TextEditingController nameController;
  late TextEditingController industryController;
  late TextEditingController bioController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController companySizeController;
  late TextEditingController headquartersController;
  late TextEditingController foundedYearController;

  // للمهارات (قائمة ديناميكية)
  List<String> skills = [];
  TextEditingController skillInputController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // هنا نقوم بتعبئة البيانات الحالية من المودل (فرضاً CompanyProfileList[0])
    // var data = companyProfileList[0];
    var data = controller.companyModel!;
    nameController = TextEditingController(text: data.name);
    industryController = TextEditingController(text: data.industry);
    bioController = TextEditingController(text: data.description);
    emailController = TextEditingController(text: data.email);
    phoneController = TextEditingController(text: data.phone);
    companySizeController =
        TextEditingController(text: data.companySize.toString());
    foundedYearController =
        TextEditingController(text: data.foundedYear.toString());
    headquartersController = TextEditingController(text: data.headquarters);

    skills = List<String>.from(data.techStack ?? []);
  }

  @override
  void addSkill() {
    if (skillInputController.text.isNotEmpty) {
      skills.add(skillInputController.text);
      skillInputController.clear();
      update();
    }
  }

  @override
  void removeSkill(index) {
    skills.removeAt(index);
    update();
  }

//ربط

  @override
  void saveAll() async {
    var formData = formState.currentState;

    // التحقق من صحة المدخلات في الفورم
    if (formData == null || formData.validate()) {
      statusRequest = StatusRequest.loading;
      print(
          "=====saveAll===========EditCompanyProfileControllerImp==============-*-Controller $statusRequest ");
      update();

      // تركيب صيغة التاريخ المطلوبة للسيرفر YYYY-MM-DD
      String formattedStartedAt = "${foundedYearController.text.trim()}-01-01";

      // 1. تجهيز البيانات الدقيقة والمطابقة لتوثيق بوستمان لارافيل
      Map<String, dynamic> updatedData = {
        "username": nameController.text.trim(),
        "description": bioController.text.trim(),
        "phone_number": phoneController.text.trim(),

        // استدعاء دالة المسارات النسبية لحفظ الصور بشكل سليم بقاعدة البيانات
        "avatar": _getRelativePath(controller.companyModel?.logoUrl),
        "cover_image": _getRelativePath(controller.companyModel?.coverUrl),

        "started_at": formattedStartedAt, // إرسال التاريخ بالصيغة المطلوبة
        "employees_count": int.tryParse(companySizeController.text.trim()) ??
            50, // التعديل لاسم الحقل الصحيح ونوعه رقم صحيح
        "tech1": skills.isNotEmpty
            ? skills.first
            : "Laravel", // إرسال التقنية الأولى
      };

      print("--- البيانات المرسلة للباك-إند: $updatedData");

      // 2. إرسال طلب التحديث (PUT) للسيرفر
      String token = myServices.sharedPreferences.getString("token")!;
      String userId = myServices.sharedPreferences.getString("user_id")!;

      var response =
          await companyData.editProfileInfo(userId, token, updatedData);

      print(
          "=====saveAll============EditCompanyProfileControllerImp=============* Response: $response ");
      print(
          "=====saveAll===========EditCompanyProfileControllerImp==============-*-Controller $statusRequest ");
      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response['data'] != null) {
          // 3. الخطوة الأهم: تحويل البيانات المحدثة المرجعة من السيرفر لموديل جديد
          CompanyProfileModel updatedModel =
              CompanyProfileModel.fromJson(response['data']);

          // 4. عكس وتحديث البيانات مباشرة في الكنترولر الرئيسي للـ Navigation Bar والبروفايل
          controller.companyModel = updatedModel;
          controller.update(); // لتحديث واجهة البروفايل فوراً بالبيانات الجديدة

          Get.back(); // العودة لواجهة البروفايل
          Get.snackbar("نجاح", "تم تحديث بياناتك بنجاح",
              backgroundColor: Colors.green, colorText: Colors.white);

          statusRequest = StatusRequest.none;
        } else {
          statusRequest = StatusRequest.failure;
        }
      } else {
        Get.defaultDialog(
          title: "خطأ",
          middleText:
              "حدث خطأ أثناء الاتصال بالخادم، تحقق من اتصالك وأعد المحاولة.",
        );
        statusRequest = StatusRequest.none;
      }
      update();
      print(
          "=====saveAll===========EditCompanyProfileControllerImp==============-*-Controller $statusRequest ");
    }
  }

  // دالة مساعدة لتخليص مسار الصورة من رابط الـ ngrok وإرجاع المسار النسبي فقط
  String _getRelativePath(String? fullUrl) {
    if (fullUrl == null) return "";
    if (fullUrl.contains("/storage/")) {
      return fullUrl
          .split("/storage/")
          .last; // يستخلص الجزء بعد /storage/ مثل avatars/new-avatar.png
    }
    return fullUrl;
  }
  //ربط
}
