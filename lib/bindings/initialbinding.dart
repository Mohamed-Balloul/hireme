import 'package:get/get.dart';
import 'package:hireme/controller/company/savedstudents_controller.dart';
import 'package:hireme/controller/customer/customersavedstudents_controller.dart';
import 'package:hireme/controller/student/savedposts_controller.dart';
import 'package:hireme/core/class/crud.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // نضع هنا المتحكمات التي نريدها أن تعمل فور تشغيل التطبيق وتكون متاحة للجميع
    Get.put(SavedPostsControllerImp(), permanent: true);
    Get.put(SavedStudentsControllerImp(), permanent: true);
    Get.put(CustomerSavedStudentsControllerImp(), permanent: true);
    // permanent: true تضمن أن المتحكم لن يُحذف من الذاكرة أبداً
    //ربط
    Get.put(Crud());
    //ربط
  }
}
