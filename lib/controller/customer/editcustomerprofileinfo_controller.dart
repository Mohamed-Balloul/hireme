import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/customer/customerbottomnavigationbar/customerbottomnavigationbar_controller.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/core/services/services.dart';
import 'package:hireme/data/datasource/remote/customer/customer.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/data/model/customerprofilemodel.dart';
import 'package:intl/intl.dart'; // ستحتاج لإضافة حزمة intl في pubspec.yaml لتنسيق التاريخ
import 'package:image_picker/image_picker.dart';

abstract class EditCustomerProfileController extends GetxController {
  pickExperienceLogo();
  addSkill();
  removeSkill(int index);
  //ربط
  saveAll();
  //ربط

  selectDate(BuildContext context, bool isStart);
  addExperience();
  removeExperience(int index);
  deleteExperienceLogo();
}

// ملاحظة: تأكد من إضافة هذا الملف في المسار الصحيح
class EditCustomerProfileControllerImp extends EditCustomerProfileController {
  //ربط
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  CustomerBottomNavigationBarrControllerImp controller =
      Get.find<CustomerBottomNavigationBarrControllerImp>();

  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;

  CustomerData customerData = CustomerData(Get.find());

  //ربط

  // نقوم بتعريف TextControllers لكل حقل لسهولة التحكم
  late TextEditingController nameController;
  late TextEditingController jobController;
  late TextEditingController bioController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController salaryController;
  late TextEditingController locationController;
  late TextEditingController experienceYearsController;
  late TextEditingController githubController;
  late TextEditingController linkedinController;

  // للمهارات (قائمة ديناميكية)
  List<String> skills = [];
  TextEditingController skillInputController = TextEditingController();

  // للتعليم (Map)
  bool isGraduated = false;
  late TextEditingController collegeController;
  late TextEditingController uniController;
// --- حقول الخبرة المهنية ---
  List<Map<String, dynamic>> workExperiences = [];

  // حقول الإدخال لتجربة جديدة
  TextEditingController companyController = TextEditingController();
  TextEditingController jobTitleController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  bool isCurrentWork = false;
  bool isFreelancer = false;
  File? tempExperienceLogo;
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    var data = controller.customerModel!;
    nameController = TextEditingController(text: data.name);
    jobController = TextEditingController(text: data.jobLabel);
    bioController = TextEditingController(text: data.bio);
    emailController = TextEditingController(text: data.email);
    phoneController = TextEditingController(text: data.phone);
    locationController = TextEditingController(text: data.city);
    githubController = TextEditingController(text: data.github);
    linkedinController = TextEditingController(text: data.linkedIn);

    isGraduated = data.educationInfo?['isGraduated'] ?? false;
    collegeController =
        TextEditingController(text: data.educationInfo?['college']);
    uniController =
        TextEditingController(text: data.educationInfo?['university']);

    // تهيئة الحقول غير المستخدمة بالواجهة لمنع أخطاء الـ Late Initialization
    salaryController = TextEditingController(text: "75");
    experienceYearsController = TextEditingController(text: "5");
  }

  @override
  // اختيار لوغو الشركة
  Future<void> pickExperienceLogo() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      tempExperienceLogo = File(image.path);
      update();
    }
  }

  @override
  // اختيار التاريخ (بداية ونهاية)
  Future<void> selectDate(context, isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      locale: const Locale('ar', 'AE'), // لدعم التقويم العربي
    );
    if (picked != null) {
      if (isStart) {
        startDate = picked;
      } else {
        endDate = picked;
      }
      update();
    }
  }

  // التحقق من صلاحية البيانات لتفعيل زر الإضافة
  bool get isExperienceValid =>
      companyController.text.isNotEmpty &&
      jobTitleController.text.isNotEmpty &&
      startDate != null &&
      (isCurrentWork || endDate != null);

  @override
  // إضافة تجربة جديدة للقائمة
  void addExperience() {
    String endText = isCurrentWork
        ? "حتى الآن"
        : DateFormat('MMM yyyy', 'en').format(endDate!);
    String startText = DateFormat('MMM yyyy', 'en').format(startDate!);

    workExperiences.add({
      "companyName": companyController.text,
      "jobTitle": jobTitleController.text,
      "startDate": startText,
      "endDate": endText,
      "logo": tempExperienceLogo?.path ?? "", // مسار ملف محلي أو فارغ
      // "isFreelancer": tempExperienceLogo != null,
      "isFreelancer": isFreelancer,
    });

    // إعادة تهيئة الحقول بعد الإضافة
    companyController.clear();
    jobTitleController.clear();
    startDate = null;
    endDate = null;
    isCurrentWork = false;
    isFreelancer = false;
    tempExperienceLogo = null;

    update();
  }

  @override
  void removeExperience(index) {
    workExperiences.removeAt(index);
    update();
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

  @override
  void deleteExperienceLogo() {
    tempExperienceLogo = null;
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
          "=====saveAll===========EditCustomerProfileControllerImp==============-*-Controller $statusRequest ");
      update();

      // 1. تجهيز البيانات الدقيقة والمطابقة لتوثيق بوستمان لارافيل للعميل
      Map<String, dynamic> updatedData = {
        "username": nameController.text.trim(),
        "description": bioController.text.trim(),
        "phone_number": phoneController.text.trim(),

        // استدعاء دالة الـ Relative Path لمعالجة الصور وحفظها نسبية في لارافيل
        "avatar": _getRelativePath(controller.customerModel?.image),
        "cover_image": _getRelativePath(controller.customerModel?.cover),

        "address": locationController.text.trim(),
        "college": collegeController.text.trim(),
        "title": jobController.text.trim(),

        // إرسال قيم افتراضية دفاعية للحقول الإجبارية بالسيرفر وغير المتوفرة بواجهة العميل حالياً
        "hour_cost": "75",
        "experience_years": 5,
        "tech1": "Laravel",
        //--
        "git_link": githubController.text.isNotEmpty
            ? githubController.text.trim()
            : "https://github.com/Mohamed-Balloul",

        "linked_link": linkedinController.text.isNotEmpty
            ? linkedinController.text.trim()
            : "https://www.linkedin.com/in/mohamed-balloul-13b4173b3",
      };

      print("--- البيانات المرسلة للباك-إند: $updatedData");

      // 2. إرسال طلب التحديث (PUT) للسيرفر
      String token = myServices.sharedPreferences.getString("token")!;
      String userId = myServices.sharedPreferences.getString("user_id")!;

      var response =
          await customerData.editProfileInfo(userId, token, updatedData);

      print(
          "=====saveAll============EditCustomerProfileControllerImp=============* Response: $response ");
      print(
          "=====saveAll===========EditCustomerProfileControllerImp==============-*-Controller $statusRequest ");
      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response['data'] != null) {
          // 3. تحويل البيانات المحدثة المرجعة من السيرفر لموديل جديد
          CustomerProfileModel updatedModel =
              CustomerProfileModel.fromJson(response['data']);

          // 4. عكس وتحديث البيانات مباشرة في الكنترولر الرئيسي للـ Navigation Bar والبروفايل
          controller.customerModel = updatedModel;
          controller.update(); // لتحديث واجهة البروفايل فوراً بالبيانات المحدثة

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
          "=====saveAll===========EditCustomerProfileControllerImp==============-*-Controller $statusRequest ");
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
