import 'package:file_picker/file_picker.dart';
import 'package:hireme/interfaces/file_handler_interface.dart';
import 'package:hireme/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/data/model/singlefilemodel.dart';

//--
//--

abstract class SendRequestToCompanyController extends GetxController {
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
    // for (var c in fileslistControllers) {
    //   c = TextEditingController();
    // }
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
