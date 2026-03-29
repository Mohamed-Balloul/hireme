import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:intl/intl.dart'; // ستحتاج لإضافة حزمة intl في pubspec.yaml لتنسيق التاريخ
import 'package:image_picker/image_picker.dart';

abstract class EditCompanyProfileController extends GetxController {
  // pickExperienceLogo();
  addSkill();
  removeSkill(int index);
  saveAll();
  // selectDate(BuildContext context, bool isStart);
  // addExperience();
  // removeExperience(int index);
  // deleteExperienceLogo();
}

// ملاحظة: تأكد من إضافة هذا الملف في المسار الصحيح
class EditCompanyProfileControllerImp extends EditCompanyProfileController {
  // نقوم بتعريف TextControllers لكل حقل لسهولة التحكم
  late TextEditingController nameController;
  late TextEditingController industryController;
  late TextEditingController bioController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController companySizeController;
  late TextEditingController headquartersController;
  late TextEditingController foundedYearController;
  // late TextEditingController githubController;
  // late TextEditingController linkedinController;

  // للمهارات (قائمة ديناميكية)
  List<String> skills = [];
  TextEditingController skillInputController = TextEditingController();

  // للتعليم (Map)
  // bool isGraduated = false;
  // late TextEditingController collegeController;
  // late TextEditingController uniController;
// --- حقول الخبرة المهنية ---
  // List<Map<String, dynamic>> workExperiences = [];

  // حقول الإدخال لتجربة جديدة
  // TextEditingController companyController = TextEditingController();
  // TextEditingController jobTitleController = TextEditingController();
  // DateTime? startDate;
  // DateTime? endDate;
  // bool isCurrentWork = false;
  // bool isFreelancer = false;
  // File? tempExperienceLogo;
  // final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    // هنا نقوم بتعبئة البيانات الحالية من المودل (فرضاً CompanyProfileList[0])
    var data = companyProfileList[0];
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
    // experienceYearsController =
    //     TextEditingController(text: data.experienceYears.toString());
    // githubController = TextEditingController(text: data.github);
    // linkedinController = TextEditingController(text: data.linkedIn);

    skills = List<String>.from(data.techStack ?? []);

    // isGraduated = data.educationInfo?['isGraduated'] ?? false;
    // collegeController =
    //     TextEditingController(text: data.educationInfo?['college']);
    // uniController =
    //     TextEditingController(text: data.educationInfo?['university']);
    // workExperiences =
    //     List<Map<String, dynamic>>.from(data.workExperiences ?? []);
  }

  // @override
  // اختيار لوغو الشركة
  // Future<void> pickExperienceLogo() async {
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     tempExperienceLogo = File(image.path);
  //     update();
  //   }
  // }

  // @override
  // اختيار التاريخ (بداية ونهاية)
  // Future<void> selectDate(context, isStart) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime.now(),
  //     locale: const Locale('ar', 'AE'), // لدعم التقويم العربي
  //   );
  //   if (picked != null) {
  //     if (isStart) {
  //       startDate = picked;
  //     } else {
  //       endDate = picked;
  //     }
  //     update();
  //   }
  // }

  // التحقق من صلاحية البيانات لتفعيل زر الإضافة
  // bool get isExperienceValid =>
  //     companyController.text.isNotEmpty &&
  //     jobTitleController.text.isNotEmpty &&
  //     startDate != null &&
  //     (isCurrentWork || endDate != null);

  // @override
  // إضافة تجربة جديدة للقائمة
  // void addExperience() {
  //   String endText = isCurrentWork
  //       ? "حتى الآن"
  //       : DateFormat('MMM yyyy', 'en').format(endDate!);
  //   String startText = DateFormat('MMM yyyy', 'en').format(startDate!);

  //   workExperiences.add({
  //     "companyName": companyController.text,
  //     "jobTitle": jobTitleController.text,
  //     "startDate": startText,
  //     "endDate": endText,
  //     "logo": tempExperienceLogo?.path ?? "", // مسار ملف محلي أو فارغ
  //     // "isFreelancer": tempExperienceLogo != null,
  //     "isFreelancer": isFreelancer,
  //   });

  //   // إعادة تهيئة الحقول بعد الإضافة
  //   companyController.clear();
  //   jobTitleController.clear();
  //   startDate = null;
  //   endDate = null;
  //   isCurrentWork = false;
  //   isFreelancer = false;
  //   tempExperienceLogo = null;

  //   update();
  // }

  // @override
  // void removeExperience(index) {
  //   workExperiences.removeAt(index);
  //   update();
  // }

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
  void saveAll() {
    // منطق الحفظ النهائي وإرسال البيانات للسيرفر
    Get.back();
    Get.snackbar("نجاح", "تم تحديث بياناتك بنجاح",
        backgroundColor: Colors.green, colorText: Colors.white);
  }

  // @override
  // void deleteExperienceLogo() {
  //   tempExperienceLogo = null;
  //   update();
  // }
}
