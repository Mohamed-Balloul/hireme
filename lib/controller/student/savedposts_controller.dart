// // import 'package:hireme/core/constant/routes.dart';
// import 'package:hireme/core/constant/routes.dart';
// import 'package:hireme/data/datasource/static/static.dart';
// import 'package:get/get.dart';
// import 'package:hireme/data/model/companiespostmodel.dart';
// import 'package:hireme/data/model/companyprofilemodel.dart';
// import 'package:hireme/data/model/customerprofilemodel.dart';
// import 'package:hireme/view/screen/company/companyprofile.dart';
// import 'package:hireme/view/screen/customer/customerprofile.dart';
// import 'package:hireme/view/screen/student/sendrequesttocompany.dart';
// import 'package:hireme/view/screen/student/studentsearch.dart';

// abstract class SavedPostsController extends GetxController {
//   // goToPostDetails(CompanyPostModel companyPostModel);
//   goToSendRequestToCompany(CompaniesPostModel companiesPostModel);
//   goToCompanyProfile(String companyName);
//   action(int index);
//   change(int index);
//   //---

//   goToCustomerProfile(String customerName);

//   goToSendRequestToCustomer();
// }

// class SavedPostsControllerImp extends SavedPostsController {
//   int currentIndex = 0;

//   // متغير للتحكم في حالة الفتح والإغلاق

//   List<bool>? isExpanded = [];
//   @override
//   void onInit() {
//     super.onInit();
//     for (int i = 0; i < suggestedItems.length; i++) {
//       isExpanded!.add(false);
//     }
//   }

//   @override
//   action(index) {
//     isExpanded![index] = !isExpanded![index];
//     update();
//   }

//   @override
//   change(index) {
//     currentIndex = index;
//     update();
//   }

//   @override
//   goToSendRequestToCompany(companiesPostModel) {
//     Get.to(() => SendRequestToCompany(companiesPostModel: companiesPostModel));
//   }

//   @override
//   goToCompanyProfile(companyName) {
//     // البحث في قائمة بروفايلات الشركات عن الشركة التي تملك نفس الاسم
//     CompanyProfileModel? companyData = companyProfileList.firstWhere(
//       (element) => element.name == companyName,
//       orElse: () => companyProfileList[0], // قيمة افتراضية في حال عدم الوجود
//     );

//     Get.to(() => CompanyProfile(
//           company: companyData,
//           isMine: false, // لأن الزائر طالب وليس صاحب الشركة
//         ));
//   }
//   //---------

//   @override
//   goToSendRequestToCustomer() {
//     Get.toNamed(AppRoute.sendRequestToCustomer);
//   }

//   @override
//   void goToCustomerProfile(customerName) {
//     // البحث في قائمة بروفايلات الشركات عن الشركة التي تملك نفس الاسم
//     CustomerProfileModel? customerData = customerProfileList.firstWhere(
//       (element) => element.name == customerName,
//       orElse: () => customerProfileList[0], // قيمة افتراضية في حال عدم الوجود
//     );

//     Get.to(() => CustomerProfile(
//           customer: customerData,
//           isMine: false, // لأن الزائر طالب وليس صاحب الشركة
//         ));
//   }
// }
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:hireme/core/class/statusrequest.dart';
// import 'package:hireme/core/constant/color.dart';
import 'package:hireme/core/constant/routes.dart';
// import 'package:hireme/core/functions/handlingdatacontroller.dart';
// import 'package:hireme/core/services/services.dart';
// import 'package:hireme/data/datasource/remote/student/student.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/data/model/companiespostmodel.dart';
// import 'package:hireme/data/model/companyprofilemodel.dart';
import 'package:hireme/data/model/customerprofilemodel.dart';
import 'package:hireme/data/model/freelancerpostmodel.dart';
// import 'package:hireme/view/screen/company/companyprofile.dart';
import 'package:hireme/view/screen/customer/customerprofile.dart';
import 'package:hireme/view/screen/student/sendrequesttocompany.dart';

abstract class SavedPostsController extends GetxController {
  // goToPostDetails(CompanyPostModel companyPostModel);
  goToSendRequestToCompany(CompaniesPostModel companiesPostModel);
  goToCompanyProfile(String companyId);
  action(int index);
  change(int index);
  //---

  goToCustomerProfile(String customerName);

  goToSendRequestToCustomer();
}

class SavedPostsControllerImp extends SavedPostsController {
  //--ربط
  // StatusRequest statusRequest = StatusRequest.none;
  // MyServices myServices = Get.find();
  // StudentData studentData = StudentData(Get.find());

  // CompanyProfileModel? companyProfileModel;

  //--ربط
  // القائمة المركزية المخزنة في الذاكرة
  List<dynamic> savedItems = [];

  // دالة لإضافة أو حذف البوست (Toggle)
  void toggleSave(dynamic post) {
    if (isSaved(post)) {
      // إذا كان موجوداً، نحذفه (بناءً على العنوان كمعرف فريد حالياً)
      savedItems.removeWhere((item) => getTitle(item) == getTitle(post));
      Get.snackbar("نجاح", "تمت الإزالة من المحفوظات",
          // Get.snackbar("",
          snackPosition: SnackPosition.BOTTOM);
      isExpanded = [];
      for (int i = 0; i < savedItems.length; i++) {
        isExpanded!.add(false);
      }
    } else {
      // إذا لم يكن موجوداً، نضيفه
      savedItems.add(post);
      Get.snackbar("نجاح", "تمت الإضافة إلى المحفوظات",
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
    if (post is CompaniesPostModel) return post.jobTitle ?? "";
    if (post is FreelancerPostModel) return post.serviceTitle ?? "";
    return "";
  }

  // منطق الـ Expanded الخاص بالكاردات في صفحة المحفوظات
  // Map<int, bool> isExpanded = {};
  // void action(int index) {
  //   isExpanded[index] = !(isExpanded[index] ?? false);
  //   update();
  // }
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

  @override
  goToSendRequestToCompany(companiesPostModel) {
    Get.to(() => SendRequestToCompany(companiesPostModel: companiesPostModel));
  }

  @override
  goToCompanyProfile(companyId) {
    // البحث في قائمة بروفايلات الشركات عن الشركة التي تملك نفس الاسم
    // CompanyProfileModel? companyData = companyProfileList.firstWhere(
    //   (element) => element.name == companyName,
    //   orElse: () => companyProfileList[0], // قيمة افتراضية في حال عدم الوجود
    // );

    // Get.to(() => CompanyProfile(
    //       company: companyData,
    //       isMine: false, // لأن الزائر طالب وليس صاحب الشركة
    //     ));
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
    //           color:
    //               AppColor.primaryColor, // المؤشر الأخضر الدائري المعتمد لديك
    //         ),
    //       ),
    //     ),
    //   ),
    //   barrierDismissible:
    //       false, // يمنع إغلاق الديالوغ بالضغط خارجاً لضمان عدم مقاطعة العملية
    // );

    // statusRequest = StatusRequest.loading;
    // print(
    //     "=====goToCompanyProfile=========SavedPostsControllerImp================-*-Controller $statusRequest ");
    // // update();

    // // استدعاء دالة جلب معلومات الشركة بالـ ID الفعلي
    // var response = await studentData.getCompanyDataById(
    //     companyId, myServices.sharedPreferences.getString("token")!);

    // print(
    //     "=====goToCompanyProfile=========SavedPostsControllerImp======= The Response ===========* Controller $response ");
    // statusRequest = handlingData(response);
    // // 3. إغلاق ديالوغ التحميل فوراً عند انتهاء عملية الاتصال بالسيرفر (سواءً نجحت أو فشلت)
    // if (Get.isDialogOpen ?? false) {
    //   Get.back();
    // }

    // if (StatusRequest.success == statusRequest) {
    //   if (response['data'] != null) {
    //     // تعبئة البيانات في الموديل بنجاح وبشكل مباشر
    //     companyProfileModel = CompanyProfileModel.fromJson(response['data']);

    //     // الانتقال لصفحة البروفايل وتمرير الموديل
    //     Get.to(() => CompanyProfile(
    //           company: companyProfileModel!,
    //           isMine: false, // الزائر طالب
    //         ));
    //   } else {
    //     statusRequest = StatusRequest.none;
    //   }
    // } else {
    //   statusRequest = StatusRequest.none;
    //   // إظهار رسالة تنبيه سريعة في حال فشل الاتصال بالشبكة
    //   Get.snackbar(
    //     "خطأ في الاتصال",
    //     "تعذر جلب معلومات الشركة، يرجى التحقق من الإنترنت وإعادة المحاولة",
    //     backgroundColor: Colors.red,
    //     colorText: Colors.white,
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    //   statusRequest = StatusRequest.none;
    // }
    // update();
    // print(
    //     "****goToCompanyProfile****SavedPostsControllerImp****************** *-*-* $statusRequest");
  }
  //---------

  @override
  goToSendRequestToCustomer() {
    Get.toNamed(AppRoute.sendRequestToCustomer);
  }

  @override
  void goToCustomerProfile(customerName) {
    // البحث في قائمة بروفايلات الشركات عن الشركة التي تملك نفس الاسم
    CustomerProfileModel? customerData = customerProfileList.firstWhere(
      (element) => element.name == customerName,
      orElse: () => customerProfileList[0], // قيمة افتراضية في حال عدم الوجود
    );

    Get.to(() => CustomerProfile(
          customer: customerData,
          isMine: false, // لأن الزائر طالب وليس صاحب الشركة
        ));
  }
  //------------
}
