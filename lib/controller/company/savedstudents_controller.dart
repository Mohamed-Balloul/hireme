import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/data/model/studentprofilemodel.dart';
import 'package:hireme/view/screen/student/studentprofile.dart';

abstract class SavedStudentsController extends GetxController {
  // goToPostDetails(CompanyPostModel companyPostModel);
  // goToSendRequestToCompany(CompaniesPostModel companiesPostModel);
  // goToCompanyProfile(String companyName);
  action(int index);
  change(int index);
  goToStudentProfile(String studentId);
  //---

  // goToCustomerProfile(String customerName);

  // goToSendRequestToCustomer();
}

class SavedStudentsControllerImp extends SavedStudentsController {
  // القائمة المركزية المخزنة في الذاكرة
  List<dynamic> savedItems = [];

  // دالة لإضافة أو حذف البوست (Toggle)
  void toggleSave(dynamic post) {
    if (isSaved(post)) {
      // إذا كان موجوداً، نحذفه (بناءً على العنوان كمعرف فريد حالياً)
      savedItems.removeWhere((item) => getTitle(item) == getTitle(post));
      Get.snackbar("نجاح", "تمت إزالة الطالب",
          // Get.snackbar("",
          snackPosition: SnackPosition.BOTTOM);
      isExpanded = [];
      for (int i = 0; i < savedItems.length; i++) {
        isExpanded!.add(false);
      }
    } else {
      // إذا لم يكن موجوداً، نضيفه
      savedItems.add(post);
      Get.snackbar("نجاح", "تمت إضافة الطالب",
          snackPosition: SnackPosition.BOTTOM);
      isExpanded = [];
      for (int i = 0; i < savedItems.length; i++) {
        isExpanded!.add(false);
      }
    }
    update(); // لتحديث أي واجهة تستمع لهذا المتحكم
  }

  // فحص هل البوست محفوظ أم لا
  bool isSaved(dynamic post) {
    return savedItems.any((item) => getTitle(item) == getTitle(post));
  }

  // دالة مساعدة للحصول على عنوان البوست بغض النظر عن نوع المودل
  String getTitle(dynamic post) {
    if (post is StudentProfileModel) return post.name ?? "";
    // if (post is FreelancerPostModel) return post.serviceTitle ?? "";
    return "";
  }

  //-------------
  int currentIndex = 0;

  // متغير للتحكم في حالة الفتح والإغلاق

  List<bool>? isExpanded = [];
  @override
  void onInit() {
    super.onInit();
    for (int i = 0; i < savedItems.length; i++) {
      isExpanded!.add(false);
    }
  }

  @override
  action(index) {
    isExpanded![index] = !isExpanded![index];
    update();
  }

  @override
  change(index) {
    currentIndex = index;
    update();
  }

  // @override
  // goToSendRequestToCompany(companiesPostModel) {
  //   Get.to(() => SendRequestToCompany(companiesPostModel: companiesPostModel));
  // }

  // @override
  // goToCompanyProfile(companyName) {
  //   // البحث في قائمة بروفايلات الشركات عن الشركة التي تملك نفس الاسم
  //   CompanyProfileModel? companyData = companyProfileList.firstWhere(
  //     (element) => element.name == companyName,
  //     orElse: () => companyProfileList[0], // قيمة افتراضية في حال عدم الوجود
  //   );

  //   Get.to(() => CompanyProfile(
  //         company: companyData,
  //         isMine: false, // لأن الزائر طالب وليس صاحب الشركة
  //       ));
  // }
  // //---------

  // @override
  // goToSendRequestToCustomer() {
  //   Get.toNamed(AppRoute.sendRequestToCustomer);
  // }

  // @override
  // void goToCustomerProfile(customerName) {
  //   // البحث في قائمة بروفايلات الشركات عن الشركة التي تملك نفس الاسم
  //   CustomerProfileModel? customerData = customerProfileList.firstWhere(
  //     (element) => element.name == customerName,
  //     orElse: () => customerProfileList[0], // قيمة افتراضية في حال عدم الوجود
  //   );

  //   Get.to(() => CustomerProfile(
  //         customer: customerData,
  //         isMine: false, // لأن الزائر طالب وليس صاحب الشركة
  //       ));
  // }
  //------------student.id.toString()
  @override
  goToStudentProfile(studentId) {
    // Get.to(() => StudentProfile(
    //       student: studentProfileList[index], //   المختار من السلايدر
    //       isMine: false, // الزائر شركة، لذا لا تظهر أزرار التعديل
    //       isCompany: true,
    //     ));
    // 1. إظهار ديالوغ التحميل المتناسق فوراً لمحاكاة الاتصال الفعلي
    // Get.dialog(
    //   const Center(
    //     child: Card(
    //       elevation: 4,
    //       color: Colors.white,
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.all(Radius.circular(16)),
    //       ),
    //       child: Padding(
    //         padding: EdgeInsets.all(24.0),
    //         child: CircularProgressIndicator(
    //           color: AppColor.primaryColor, // المؤشر الأخضر الدائري المعتمد
    //         ),
    //       ),
    //     ),
    //   ),
    //   barrierDismissible: false,
    // );

    // // 2. تأخير اصطناعي ناعم ومدروس لثانيتين لإضفاء الواقعية على الحركة
    // await Future.delayed(const Duration(seconds: 2));

    // // 3. إغلاق الديالوغ المنبثق بأمان
    // if (Get.isDialogOpen ?? false) {
    //   Get.back();
    // }

    // // 4. الانتقال السلس لبروفايل الطالب مع فحص المعرفات الآمن برمجياً لتفادي الـ StateError
    // Get.to(() => StudentProfile(
    //       student: allStudents
    //           .firstWhere((student) => student.id.toString() == studentId),
    //       isMine: false,
    //       isCompany: true,
    //     ));
  }
}
