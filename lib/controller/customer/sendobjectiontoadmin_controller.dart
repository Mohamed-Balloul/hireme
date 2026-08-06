// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hireme/core/class/statusrequest.dart';
// import 'package:hireme/core/functions/handlingdatacontroller.dart';
// import 'package:hireme/core/services/services.dart';
// import 'package:hireme/data/datasource/remote/customer/customer.dart';
// import 'package:hireme/data/model/freelancerpostmodel.dart'; // الموديل المشترك للمشاريع

// abstract class SendObjectionToAdminController extends GetxController {
//   getReceivedProjects();
//   selectProject(int id);
//   toggleReason(String reason);
//   submitObjection();
// }

// class SendObjectionToAdminControllerImp extends SendObjectionToAdminController {
//   GlobalKey<FormState> formState = GlobalKey<FormState>();

//   MyServices myServices = Get.find();
//   StatusRequest statusRequest = StatusRequest.none;
//   CustomerData customerData = CustomerData(Get.find());

//   // القائمة التي سنعرض فيها المشاريع القابلة للاعتراض
//   List<FreelancerPostModel> receivedProjects = [];

//   // المدخلات الأساسية للاعتراض
//   int? selectedProjectId;
//   List<String> selectedReasons = [];
//   TextEditingController explanationController = TextEditingController();

//   // قائمة الأسباب الخمسة المحددة مسبقاً بالفرونت
//   final List<String> objectionReasons = [
//     "نقص في الملفات المستلمة",
//     "الخدمة لا تلبي المطلوب",
//     "هنالك أخطاء في التنفيذ",
//     "الخدمة المستلمة مخالفة لما أنا متوقع",
//     "هنالك ضعف في الأداء"
//   ];

//   @override
//   void onInit() {
//     explanationController = TextEditingController();
//     getReceivedProjects();
//     super.onInit();
//   }

//   @override
//   void dispose() {
//     explanationController.dispose();
//     super.dispose();
//   }

//   @override
//   getReceivedProjects() async {
//     statusRequest = StatusRequest.loading;
//     update();

//     String token = myServices.sharedPreferences.getString("token")!;
//     var response = await customerData.getReceivedProjects(token);

//     statusRequest = handlingData(response);

//     if (StatusRequest.success == statusRequest) {
//       if (response["data"] != null) {
//         receivedProjects.clear();
//         List responseData = response['data'];
//         receivedProjects
//             .addAll(responseData.map((e) => FreelancerPostModel.fromJson(e)));
//       } else {
//         statusRequest = StatusRequest.failure;
//       }
//     }
//     update();
//   }

//   @override
//   void selectProject(int id) {
//     selectedProjectId = id;
//     update();
//   }

//   @override
//   void toggleReason(String reason) {
//     if (selectedReasons.contains(reason)) {
//       selectedReasons.remove(reason);
//     } else {
//       selectedReasons.add(reason);
//     }
//     update();
//   }

//   @override
//   submitObjection() async {
//     // 1. التحقق الدفاعي من صحة الإدخال بالتطبيق
//     if (selectedProjectId == null) {
//       Get.snackbar("تنبيه", "يرجى تحديد الخدمة المراد الاعتراض عليها أولاً",
//           backgroundColor: Colors.orange, colorText: Colors.white);
//       return;
//     }
//     if (explanationController.text.trim().isEmpty) {
//       Get.snackbar("تنبيه", "يرجى إضافة وصف مختصر للاعتراض",
//           backgroundColor: Colors.orange, colorText: Colors.white);
//       return;
//     }

//     var formData = formState.currentState;
//     if (formData!.validate()) {
//       statusRequest = StatusRequest.loading;
//       update();

//       // تجهيز كائن الطلب لإرساله للباك
//       Map<String, dynamic> data = {
//         "project_id": selectedProjectId,
//         // "reasons": selectedReasons, // مصفوفة الأسباب المحددة
//         "details": explanationController.text.trim(), // الوصف الاختياري
//       };

//       String token = myServices.sharedPreferences.getString("token")!;
//       var response = await customerData.sendObjectionToAdmin(data, token);

//       statusRequest = handlingData(response);

//       if (StatusRequest.success == statusRequest) {
//         if (response["message"] == "Objection submitted successfully.") {
//           // إظهار رسالة النجاح المنصوص عليها في المخطط الخاص بك
//           Get.defaultDialog(
//               title: "تم الإرسال بنجاح",
//               middleText:
//                   "تم الإرسال بنجاح! راقب الإشعارات لتعرف نتيجة الاعتراض .",
//               textConfirm: "حسناً",
//               confirmTextColor: Colors.white,
//               buttonColor: Colors.green,
//               onConfirm: () {
//                 Get.back(); // إغلاق الدايلوج
//                 Get.back(); // العودة للشاشة السابقة
//               });

//           _resetFields();
//         } else {
//           Get.snackbar("فشل", "حدث خطأ ما أثناء إرسال الاعتراض، حاول مجدداً",
//               backgroundColor: Colors.red, colorText: Colors.white);
//           statusRequest = StatusRequest.failure;
//         }
//       }
//       update();
//     }
//   }

//   void _resetFields() {
//     selectedProjectId = null;
//     selectedReasons.clear();
//     explanationController.clear();
//     statusRequest = StatusRequest.none;
//     update();
//   }
// }
//------------------

//--------

//--

// تحديث كلاس SendObjectionToAdminControllerImp ليستخدم الموديل الجديد:

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/core/services/services.dart';
import 'package:hireme/data/datasource/remote/customer/customer.dart';
import 'package:hireme/data/model/eligible_objection_model.dart';

abstract class SendObjectionToAdminController extends GetxController {
  getReceivedProjects();
  selectProject(int id);
  toggleReason(String reason);
  submitObjection();
}

class SendObjectionToAdminControllerImp extends SendObjectionToAdminController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  CustomerData customerData = CustomerData(Get.find());

  // القائمة التي سنعرض فيها المشاريع القابلة للاعتراض بنوع الموديل الجديد
  List<EligibleObjectionModel> receivedProjects = [];

  // المدخلات الأساسية للاعتراض
  int? selectedProjectId;
  List<String> selectedReasons = [];
  TextEditingController explanationController = TextEditingController();

  @override
  void onInit() {
    explanationController = TextEditingController();
    getReceivedProjects();
    super.onInit();
  }

  @override
  void dispose() {
    explanationController.dispose();
    super.dispose();
  }

  @override
  getReceivedProjects() async {
    statusRequest = StatusRequest.loading;
    print(
        "=========getReceivedProjects==========SendObjectionToAdminControllerImp===========-*-Controller $statusRequest ");
    update();

    String token = myServices.sharedPreferences.getString("token")!;
    var response = await customerData.getReceivedProjects(token);
    print(
        "=========getReceivedProjects=======SendObjectionToAdminControllerImp==============* Controller $response ");
    print(
        "=========getReceivedProjects=======SendObjectionToAdminControllerImp==============* Controller $statusRequest");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response["data"] != null) {
        receivedProjects.clear();
        List responseData = response['data'];
        // تحويل وتعبئة الموديل الجديد
        receivedProjects.addAll(
            responseData.map((e) => EligibleObjectionModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
    print(
        "=========getReceivedProjects=======SendObjectionToAdminControllerImp==============* Controller $statusRequest");
  }

  // @override
  // void selectProject(int id) {
  //   selectedProjectId = id;
  //   update();
  // }
// داخل كلاس SendObjectionToAdminControllerImp بملف الكنترولر قم بتعديل الدالة لتصبح كالتالي:

  @override
  void selectProject(int id) {
    if (selectedProjectId == id) {
      selectedProjectId =
          null; // إلغاء التحديد تماماً إذا تم الضغط على نفس المشروع المحدد مسبقاً
    } else {
      selectedProjectId = id; // تحديد المشروع بشكل طبيعي إذا كان غير محدد
    }
    update(); // تحديث الواجهة فوراً لرؤية النتيجة بصرية
  }

  @override
  void toggleReason(String reason) {
    if (selectedReasons.contains(reason)) {
      selectedReasons.remove(reason);
    } else {
      selectedReasons.add(reason);
    }
    update();
  }

  @override
  submitObjection() async {
    if (selectedProjectId == null) {
      Get.snackbar("تنبيه", "يرجى تحديد الخدمة المراد الاعتراض عليها أولاً",
          backgroundColor: Colors.orange, colorText: Colors.white);
      return;
    }
    if (explanationController.text.trim().isEmpty) {
      Get.snackbar("تنبيه", "يرجى إضافة وصف مختصر للاعتراض",
          backgroundColor: Colors.orange, colorText: Colors.white);
      return;
    }

    var formData = formState.currentState;
    if (formData!.validate()) {
      statusRequest = StatusRequest.loading;
      print(
          "=========submitObjection==========SendObjectionToAdminControllerImp===========-*-Controller $statusRequest ");
      update();

      Map<String, dynamic> data = {
        "project_application_id": selectedProjectId,
        "description": explanationController.text.trim(),
      };
      print("the data to be sent: $data");

      String token = myServices.sharedPreferences.getString("token")!;
      var response = await customerData.sendObjectionToAdmin(data, token);
      print(
          "=========submitObjection=======SendObjectionToAdminControllerImp==============* Controller $response ");
      print(
          "=========submitObjection=======SendObjectionToAdminControllerImp==============* Controller $statusRequest");
      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response["message"] == "Objection submitted successfully.") {
          Get.defaultDialog(
              title: "تم الإرسال بنجاح",
              middleText:
                  "تم الإرسال بنجاح! راقب الإشعارات لتعرف نتيجة الاعتراض .",
              textConfirm: "حسناً",
              confirmTextColor: Colors.white,
              buttonColor: Colors.green,
              onConfirm: () {
                Get.back();
                Get.back();
              });

          _resetFields();
        } else {
          Get.snackbar("فشل", "حدث خطأ ما أثناء إرسال الاعتراض، حاول مجدداً",
              backgroundColor: Colors.red, colorText: Colors.white);
          statusRequest = StatusRequest.failure;
        }
      }
      update();
      print(
          "=========submitObjection=======SendObjectionToAdminControllerImp==============* Controller $statusRequest");
    }
  }

  void _resetFields() {
    selectedProjectId = null;
    selectedReasons.clear();
    explanationController.clear();
    statusRequest = StatusRequest.none;
    update();
  }
}
