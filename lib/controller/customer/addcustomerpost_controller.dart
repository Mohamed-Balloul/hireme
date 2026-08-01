// import 'package:file_picker/file_picker.dart';
// import 'package:hireme/core/class/statusrequest.dart';
// import 'package:hireme/core/constant/routes.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hireme/core/functions/handlingdatacontroller.dart';
// import 'package:hireme/core/services/services.dart';
// import 'package:hireme/data/datasource/remote/customer/customer.dart';
// import 'package:hireme/data/model/attachedfileitemmodel.dart';

// abstract class AddCustomerPostController extends GetxController {
//   goToSignIn();
//   //
//   showHidePassword();
//   selectType(String type);
//   onCvCheck(bool? value);
//   onGitHubOrPortfolioCheck(bool? value);
//   onPreSamplesCheck(bool? value);
//   onSalaryCheck(bool? value);
//   //
//   addField(List<TextEditingController> list);
//   addFile();
//   removeField(List<TextEditingController> list, int index);
//   removeFile(int index);
//   //
//   pickAndAddFile();
//   //
//   getFileIcon(String? extension);
//   //--
//   createCustomerPost();
// }

// class AddCustomerPostControllerImp extends AddCustomerPostController {
//   GlobalKey<FormState> formState = GlobalKey<FormState>();
//   //
//   // 1. تعريف المتحكمات للنصوص البسيطة
//   TextEditingController titleController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   TextEditingController detailsController = TextEditingController();

//   // 2. تعريف قوائم المتحكمات للقوائم المتعددة (المهام، المتطلبات، الميزات)
//   List<TextEditingController> dutiesControllers = [TextEditingController()];
//   List<TextEditingController> requirementsControllers = [
//     TextEditingController()
//   ];
//   List<TextEditingController> featuresControllers = [TextEditingController()];
//   // List<TextEditingController> fileslistControllers = [];

//   List<AttachedFileItemModel> attachedFiles = [];

//   // 3. متغيرات للخيارات (Checkboxes)
//   bool reqCVIsChecked = false;
//   bool reqPortfolioIsChecked = false;
//   bool reqSamplesIsChecked = false;
//   bool reqSalaryIsChecked = false;
//   //
//   PlatformFile? pickedFile;
//   //
//   int c = 0;
//   //
//   //ربط
//   MyServices myServices = Get.find();
//   StatusRequest statusRequest = StatusRequest.none;

//   CustomerData customerData = CustomerData(Get.find());

//   // List data = [];
//   //ربط

//   @override
//   goToSignIn() {
//     Get.offNamed(AppRoute.login);
//   }

//   @override
//   void onInit() {
//     titleController = TextEditingController();
//     detailsController = TextEditingController();
//     descriptionController = TextEditingController();
//     for (var c in dutiesControllers) {
//       c = TextEditingController();
//     }
//     for (var c in requirementsControllers) {
//       c = TextEditingController();
//     }
//     for (var c in featuresControllers) {
//       c = TextEditingController();
//     }
//     // for (var c in fileslistControllers) {
//     //   c = TextEditingController();
//     // }
//     super.onInit();
//   }

//   @override
//   void dispose() {
//     titleController.dispose();
//     detailsController.dispose();
//     descriptionController.dispose();
//     for (var c in dutiesControllers) {
//       c.dispose();
//     }
//     for (var c in requirementsControllers) {
//       c.dispose();
//     }
//     for (var c in featuresControllers) {
//       c.dispose();
//     }
//     // for (var c in fileslistControllers) {
//     //   c.dispose();
//     // }
//     super.dispose();
//   }

//   @override
//   showHidePassword() {}

//   @override
//   selectType(type) {}

//   @override
//   // دالة مساعدة لإضافة حقل جديد للقوائم
//   void addField(list) {
//     if (list.length < 5) {
//       list.add(TextEditingController());
//       update();
//     }
//   }

//   @override
//   // دالة مساعدة لحذف حقل من القوائم
//   void removeField(list, index) {
//     if (list.length > 0) {
//       list[index].dispose(); // تنظيف الذاكرة
//       list.removeAt(index);
//       update();
//     }
//   }

//   @override
//   onCvCheck(value) {
//     reqCVIsChecked = value!;
//     update();
//   }

//   @override
//   onGitHubOrPortfolioCheck(value) {
//     reqPortfolioIsChecked = value!;
//     update();
//   }

//   @override
//   onPreSamplesCheck(value) {
//     reqSamplesIsChecked = value!;
//     update();
//   }

//   @override
//   onSalaryCheck(value) {
//     reqSalaryIsChecked = value!;
//     update();
//   }

//   @override
//   pickAndAddFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom, // تحديد نوع مخصص
//       allowedExtensions: ['pdf', 'doc', 'docx'], // السماح فقط بملفات المستندات
//     );
//     attachedFiles.add(AttachedFileItemModel(
//         file: result!.files.first,
//         descriptionController: TextEditingController()));
//     update();
//   }

// // دالة حذف ملف من القائمة
//   @override
//   removeFile(index) {
//     attachedFiles[index].descriptionController.dispose(); // تنظيف الذاكرة
//     attachedFiles.removeAt(index);
//     update();
//   }

//   @override
//   addFile() {
//     update();
//   }

//   // دالة مساعدة لمعرفة أيقونة الملف بناءً على لاحقته
//   @override
//   getFileIcon(extension) {
//     switch (extension?.toLowerCase()) {
//       case 'pdf':
//         return const Icon(Icons.picture_as_pdf, color: Colors.red, size: 40);
//       case 'doc':
//       case 'docx':
//         return const Icon(Icons.description, color: Colors.blue, size: 40);
//       case 'jpg':
//       case 'jpeg':
//       case 'png':
//         return const Icon(Icons.image, color: Colors.green, size: 40);
//       default:
//         return const Icon(Icons.insert_drive_file,
//             color: Colors.grey, size: 40);
//     }
//   }

//   @override
//   createCustomerPost() async {
//     var formData = formState.currentState;
//     if (formData!.validate()) {
//       statusRequest = StatusRequest.loading;
//       update();

//       // --- تجهيز البيانات (Mapping) بناءً على توثيق Postman ---
//       Map<String, dynamic> data = {
//         "name": titleController.text,
//         "additional_details": detailsController.text,
//         "details": descriptionController.text,
//       };

//       // إضافة المتطلبات (req1, req2, ...)
//       for (int i = 0; i < dutiesControllers.length; i++) {
//         if (dutiesControllers[i].text.isNotEmpty && i < 5) {
//           data["tool${i + 1}"] = dutiesControllers[i].text;
//         }
//       }

//       // إرسال الطلب للسيرفر
//       String token = myServices.sharedPreferences.getString("token")!;
//       var response = await customerData.createCustomerPost(data, token);

//       statusRequest = handlingData(response);

//       if (StatusRequest.success == statusRequest) {
//         if (response["message"] == "Project created successfully.") {
//           // نجاح العملية
//           // Get.back(); // العودة للخلف أو للهوم
//           Get.snackbar("نجاح", "تم نشر الإعلان بنجاح",
//               backgroundColor: Colors.green, colorText: Colors.white);

//           // (اختياري) تحديث قائمة الإعلانات في صفحة الهوم فوراً
//           // if (Get.isRegistered<CompanyHomeControllerImp>()) {
//           //   // Get.find<CompanyHomeControllerImp>().getAds();
//           // }
//         } else {
//           Get.defaultDialog(
//               title: "تنبيه", middleText: "فشل في نشر الإعلان، حاول مجدداً");
//           statusRequest = StatusRequest.failure;
//         }
//       }
//       update();
//     } else {}
//   }
// }
import 'package:file_picker/file_picker.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/core/services/services.dart';
import 'package:hireme/data/datasource/remote/customer/customer.dart';
import 'package:hireme/data/model/attachedfileitemmodel.dart';
import 'package:hireme/data/model/createprojectrequestmodel.dart'; // استيراد الموديل الجديد

abstract class AddCustomerPostController extends GetxController {
  goToSignIn();
  showHidePassword();
  selectType(String type);
  onCvCheck(bool? value);
  onGitHubOrPortfolioCheck(bool? value);
  onPreSamplesCheck(bool? value);
  onSalaryCheck(bool? value);
  addField(List<TextEditingController> list);
  addFile();
  removeField(List<TextEditingController> list, int index);
  removeFile(int index);
  pickAndAddFile();
  getFileIcon(String? extension);
  createCustomerPost();
}

class AddCustomerPostControllerImp extends AddCustomerPostController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  // 1. متحكمات النصوص البسيطة
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  // 2. قوائم المتحكمات
  List<TextEditingController> dutiesControllers = [TextEditingController()];
  List<TextEditingController> requirementsControllers = [
    TextEditingController()
  ];
  List<TextEditingController> featuresControllers = [TextEditingController()];

  List<AttachedFileItemModel> attachedFiles = [];

  // 3. الخيارات
  bool reqCVIsChecked = false;
  bool reqPortfolioIsChecked = false;
  bool reqSamplesIsChecked = false;
  bool reqSalaryIsChecked = false;

  PlatformFile? pickedFile;
  int c = 0;

  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  CustomerData customerData = CustomerData(Get.find());

  @override
  goToSignIn() {
    Get.offNamed(AppRoute.login);
  }

  @override
  void onInit() {
    // تم تصحيح طريقة التهيئة وإزالة الحلقات التكرارية غير الصحيحة
    titleController = TextEditingController();
    detailsController = TextEditingController();
    descriptionController = TextEditingController();
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
    for (var item in attachedFiles) {
      item.descriptionController.dispose();
    }
    super.dispose();
  }

  @override
  showHidePassword() {}

  @override
  selectType(type) {}

  @override
  void addField(list) {
    if (list.length < 5) {
      list.add(TextEditingController());
      update();
    }
  }

  @override
  void removeField(list, index) {
    if (list.length > 1) {
      // تم التعديل لمنع مسح الحقل الأخير بالكامل وتجنب كراش الواجهة
      list[index].dispose();
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
  pickAndAddFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );
    if (result != null) {
      attachedFiles.add(AttachedFileItemModel(
          file: result.files.first,
          descriptionController: TextEditingController()));
      update();
    }
  }

  @override
  removeFile(index) {
    attachedFiles[index].descriptionController.dispose();
    attachedFiles.removeAt(index);
    update();
  }

  @override
  addFile() {
    update();
  }

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
// استبدل كود دالة createCustomerPost بداخل كلاس AddCustomerPostControllerImp بالكود المحدث التالي:

  @override
  createCustomerPost() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      statusRequest = StatusRequest.loading;
      print(
          "========createCustomerPost======================-*-Controller $statusRequest ");
      update();

      // 1. تجميع الأدوات وتصفية الحقول الفارغة
      List<String> tools = dutiesControllers
          .map((c) => c.text.trim())
          .where((text) => text.isNotEmpty)
          .toList();

      // 2. إلغاء دمج النصوص وإعدادها كحقول مستقلة تماماً لمطابقة تحديث الباك-إند
      String finalDetails = descriptionController.text.trim();
      String finalAdditionalDetails = detailsController.text.trim();

      // 3. بناء الموديل المحدث والمنظم
      CreateProjectRequestModel requestModel = CreateProjectRequestModel(
        name: titleController.text.trim(),
        details: finalDetails.isEmpty ? "لا توجد تفاصيل متوفرة" : finalDetails,
        additionalDetails: finalAdditionalDetails.isEmpty
            ? "لا تتوفر تفاصيل إضافية"
            : finalAdditionalDetails,
        tools: tools,
      );

      // 4. إرسال البيانات
      String token = myServices.sharedPreferences.getString("token")!;
      var response =
          await customerData.createCustomerPost(requestModel.toJson(), token);
      print(
          "======createCustomerPost========================* Controller $response ");
      print(
          "=====createCustomerPost=========================--Controller $statusRequest ");
      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response["message"] == "Project created successfully.") {
          Get.snackbar("نجاح", "تم نشر المشروع بنجاح",
              backgroundColor: Colors.green, colorText: Colors.white);
          _clearAllFields(); // تفريغ الحقول بأمان
        } else {
          Get.defaultDialog(
              title: "تنبيه", middleText: "فشل في نشر الإعلان، حاول مجدداً");
          statusRequest = StatusRequest.failure;
        }
      }
      update();
      print(
          "*****createCustomerPost********************* *-*-* $statusRequest");
    } else {}
  }
  // @override
  // createCustomerPost() async {
  //   var formData = formState.currentState;
  //   if (formData!.validate()) {
  //     statusRequest = StatusRequest.loading;
  //     print(
  //         "========createCustomerPost======================-*-Controller $statusRequest ");
  //     update();

  //     // 1. تجميع الأدوات وتصفية الحقول الفارغة
  //     List<String> tools = dutiesControllers
  //         .map((c) => c.text.trim())
  //         .where((text) => text.isNotEmpty)
  //         .toList();

  //     // 2. دمج الوصف مع التفاصيل الإضافية ليتناسب مع حقل details الوحيد لدى السيرفر
  //     String finalDetails = "";
  //     if (descriptionController.text.trim().isNotEmpty) {
  //       finalDetails += "الوصف: ${descriptionController.text.trim()}\n\n";
  //     }
  //     if (detailsController.text.trim().isNotEmpty) {
  //       finalDetails += "تفاصيل إضافية: ${detailsController.text.trim()}";
  //     }

  //     // 3. بناء الموديل وإرسال حقل cover_image الافتراضي داخله تلقائياً
  //     CreateProjectRequestModel requestModel = CreateProjectRequestModel(
  //       name: titleController.text.trim(),
  //       details: finalDetails.isEmpty ? "لا توجد تفاصيل" : finalDetails,
  //       tools: tools,
  //     );

  //     // 4. إرسال البيانات
  //     String token = myServices.sharedPreferences.getString("token")!;
  //     var response =
  //         await customerData.createCustomerPost(requestModel.toJson(), token);
  //     print(
  //         "======createCustomerPost========================* Controller $response ");
  //     print(
  //         "=====createCustomerPost=========================--Controller $statusRequest ");
  //     statusRequest = handlingData(response);

  //     if (StatusRequest.success == statusRequest) {
  //       if (response["message"] == "Project created successfully.") {
  //         Get.snackbar("نجاح", "تم نشر المشروع بنجاح",
  //             backgroundColor: Colors.green, colorText: Colors.white);
  //         _clearAllFields(); // تفريغ الحقول بأمان
  //       } else {
  //         Get.defaultDialog(
  //             title: "تنبيه", middleText: "فشل في نشر الإعلان، حاول مجدداً");
  //         statusRequest = StatusRequest.failure;
  //       }
  //     }
  //     update();
  //     print(
  //         "*****createCustomerPost********************* *-*-* $statusRequest");
  //   } else {}
  // }

  // تفريغ الحقول وتنظيف الذاكرة بأمان لمنع تسريب الذاكرة (Memory Leak)
  void _clearAllFields() {
    titleController.clear();
    descriptionController.clear();
    detailsController.clear();

    for (var c in dutiesControllers) {
      c.dispose();
    }
    for (var c in requirementsControllers) {
      c.dispose();
    }
    for (var c in featuresControllers) {
      c.dispose();
    }
    for (var item in attachedFiles) {
      item.descriptionController.dispose();
    }

    dutiesControllers = [TextEditingController()];
    requirementsControllers = [TextEditingController()];
    featuresControllers = [TextEditingController()];
    attachedFiles.clear();

    statusRequest = StatusRequest.none;
    update();
  }
}
