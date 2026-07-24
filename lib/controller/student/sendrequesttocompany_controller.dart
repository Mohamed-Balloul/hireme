import 'package:file_picker/file_picker.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/core/services/services.dart';
import 'package:hireme/data/datasource/remote/student/student.dart';
import 'package:hireme/interfaces/file_handler_interface.dart';
import 'package:hireme/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/data/model/singlefilemodel.dart';

//--
//--

abstract class SendRequestToCompanyController extends GetxController {
  createAndSendApplicationToCompany(int adId);
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
  addFile();
  removeField(List<TextEditingController> list, int index);
  // removeFile(int index);
  //
  pickAndAddCvFile();
  //
  // getFileIcon(String? extension);
}

class SendRequestToCompanyControllerImp extends SendRequestToCompanyController
    implements FileHandlerInterface {
  //--ربط
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  StudentData studentData = StudentData(Get.find());
  //--ربط
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  //
  // 1. تعريف المتحكمات للنصوص البسيطة
  TextEditingController githubLinkController = TextEditingController();
  TextEditingController expectedSalaryController = TextEditingController();

  // 2. تعريف قوائم المتحكمات للقوائم المتعددة (المهام، المتطلبات، الميزات)
  List<TextEditingController> dutiesControllers = [TextEditingController()];
  List<TextEditingController> requirementsControllers = [
    TextEditingController()
  ];
  List<TextEditingController> featuresControllers = [TextEditingController()];
  // List<TextEditingController> fileslistControllers = [];

  List<SingleFileModel> attachedFiles = [];

  // 3. متغيرات للخيارات (Checkboxes)
  bool reqCVIsChecked = false;
  bool reqPortfolioIsChecked = false;
  bool reqSamplesIsChecked = false;
  bool reqSalaryIsChecked = false;
  //
  PlatformFile? cvFile;
  // String? gitHubLink;
  //
  int c = 0;

  @override
  goToSignIn() {
    Get.offNamed(AppRoute.login);
  }

//ربط
  @override
  createAndSendApplicationToCompany(adId) async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      statusRequest = StatusRequest.loading;
      print(
          "========createAndSendApplicationToCompany======================-*-Controller $statusRequest ");
      update();
      // بعد ما ينجح الـ API call
      // await Future.delayed(const Duration(seconds: 5)); // أضف هذا السطر
      // ثم انتقل لصفحة الـ

      var response = await studentData.createAndSendApplicationToCompany(
        myServices.sharedPreferences.getString("token")!,
        adId,
        int.parse(expectedSalaryController.text),
        githubLinkController.text,
      );

      print(
          "======createAndSendApplicationToCompany========================* Controller $response ");
      print(
          "=====createAndSendApplicationToCompany=========================--Controller $statusRequest ");

      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        // Start backend
        // if (response['status'] == "success") {
        if (response['data'] != null) {
          // data.addAll(response['data']);
          // Get.offNamed(AppRoute.verfiyCodeSignUp);
          Get.defaultDialog(
            title: "نجاح",
            middleText: "تم إرسال الطلب بنجاح!",
          );
          statusRequest = StatusRequest.none;
        } else {
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

      print(
          "*****createAndSendApplicationToCompany********************* *-*-* $statusRequest");
    } else {}
  }
  //--
  //  var formData = formState.currentState;
  //   if (formData!.validate()) {

  //   } else {}
  //--

//ربط
  @override
  void onInit() {
    githubLinkController = TextEditingController();
    expectedSalaryController = TextEditingController();
    for (var c in dutiesControllers) {
      c = TextEditingController();
    }
    for (var c in requirementsControllers) {
      c = TextEditingController();
    }
    for (var c in featuresControllers) {
      c = TextEditingController();
    }
    // for (var c in fileslistControllers) {
    //   c = TextEditingController();
    // }
    super.onInit();
  }

  @override
  void dispose() {
    githubLinkController.dispose();
    expectedSalaryController.dispose();
    for (var c in dutiesControllers) {
      c.dispose();
    }
    for (var c in requirementsControllers) {
      c.dispose();
    }
    for (var c in featuresControllers) {
      c.dispose();
    }
    // for (var c in fileslistControllers) {
    //   c.dispose();
    // }
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
    if (list.length > 0) {
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

  @override
  pickAndAddCvFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom, // تحديد نوع مخصص
      allowedExtensions: ['pdf', 'doc', 'docx'], // السماح فقط بملفات المستندات
    );
    cvFile = result!.files.first;
    update();
  }

// دالة حذف ملف من القائمة
  @override
  removeCvFile() {
    cvFile = null;
    update();
  }

  @override
  addFile() {
    update();
  }

  // دالة مساعدة لمعرفة أيقونة الملف بناءً على لاحقته
  @override
  getFileIcon(extension) {
    switch (extension?.toLowerCase()) {
      case 'pdf':
        return const Icon(Icons.picture_as_pdf, color: Colors.red, size: 40);
      case 'doc':
      case 'docx':
        return const Icon(Icons.description, color: Colors.blue, size: 40);
      case 'jpg':
      case 'jpeg':
      case 'png':
        return const Icon(Icons.image, color: Colors.green, size: 40);
      default:
        return const Icon(Icons.insert_drive_file,
            color: Colors.grey, size: 40);
    }
  }
}
