// import 'package:hireme/core/constant/routes.dart';
import 'package:flutter/material.dart'; // استيراد ويدجت فلاتر الأساسية

import 'package:hireme/controller/student/studenthome_controller.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/core/constant/routes.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/core/services/services.dart';
import 'package:hireme/data/datasource/remote/student/student.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:get/get.dart';
import 'package:hireme/data/model/companiespostmodel.dart';
import 'package:hireme/data/model/companyprofilemodel.dart';
import 'package:hireme/data/model/customerprofilemodel.dart';
import 'package:hireme/data/model/freelancerpostmodel.dart';
import 'package:hireme/view/screen/company/companyprofile.dart';
import 'package:hireme/view/screen/customer/customerprofile.dart';
import 'package:hireme/view/screen/student/sendrequesttocompany.dart';
import 'package:hireme/view/screen/student/sendrequesttocustomer.dart';
import 'package:hireme/view/screen/student/studentsearch.dart';

abstract class StudentSuggestionsController extends GetxController {
  // goToPostDetails(CompanyPostModel companyPostModel);
  goToSendRequestToCompany(CompaniesPostModel companiesPostModel);
  goToSendRequestToCustomer(FreelancerPostModel freelancerPostModel);
  goToCompanyProfile(String companyId);
  action(int index);
  change(int index);
  //---

  goToCustomerProfile(String customerId);
  // action(int index);
  // change(int index);
  // goToSendRequestToCustomer();
  //--
  makeSuggestionsPosts();
}

class StudentSuggestionsControllerImp extends StudentSuggestionsController {
  //--
  StudentHomeControllerImp homeController =
      Get.find<StudentHomeControllerImp>();
  List<dynamic> suggestionsAds = [];
  //--
  int currentIndex = 0;
  //--
  //--ربط
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusRequest1 = StatusRequest.none;
  MyServices myServices = Get.find();
  StudentData studentData = StudentData(Get.find());

  CompanyProfileModel? companyProfileModel;
  CustomerProfileModel? customerProfileModel;

  //--ربط
  //--

  // متغير للتحكم في حالة الفتح والإغلاق

  List<bool>? isExpanded = [];
  @override
  void onInit() {
    super.onInit();
    for (int i = 0; i < suggestionsAds.length; i++) {
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
  goToCompanyProfile(companyId) async {
    // البحث في قائمة بروفايلات الشركات عن الشركة التي تملك نفس الاسم
    // CompanyProfileModel? companyData = companyProfileList.firstWhere(
    //   (element) => element.name == companyName,
    //   orElse: () => companyProfileList[0], // قيمة افتراضية في حال عدم الوجود
    // );

    // Get.to(() => CompanyProfile(
    //       company: companyData,
    //       isMine: false, // لأن الزائر طالب وليس صاحب الشركة
    //     ));
    Get.dialog(
      const Center(
        child: Card(
          elevation: 4,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: CircularProgressIndicator(
              color:
                  AppColor.primaryColor, // المؤشر الأخضر الدائري المعتمد لديك
            ),
          ),
        ),
      ),
      barrierDismissible:
          false, // يمنع إغلاق الديالوغ بالضغط خارجاً لضمان عدم مقاطعة العملية
    );

    statusRequest = StatusRequest.loading;
    print(
        "=====goToCompanyProfile=========StudentSuggestionsControllerImp================-*-Controller $statusRequest ");
    // update();

    // استدعاء دالة جلب معلومات الشركة بالـ ID الفعلي
    var response = await studentData.getCompanyDataById(
        companyId, myServices.sharedPreferences.getString("token")!);

    print(
        "=====goToCompanyProfile=========StudentSuggestionsControllerImp======= The Response ===========* Controller $response ");
    statusRequest = handlingData(response);
    // 3. إغلاق ديالوغ التحميل فوراً عند انتهاء عملية الاتصال بالسيرفر (سواءً نجحت أو فشلت)
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }

    if (StatusRequest.success == statusRequest) {
      if (response['data'] != null) {
        // تعبئة البيانات في الموديل بنجاح وبشكل مباشر
        companyProfileModel = CompanyProfileModel.fromJson(response['data']);

        // الانتقال لصفحة البروفايل وتمرير الموديل
        Get.to(() => CompanyProfile(
              company: companyProfileModel!,
              isMine: false, // الزائر طالب
            ));
      } else {
        statusRequest = StatusRequest.none;
      }
    } else {
      statusRequest = StatusRequest.none;
      // إظهار رسالة تنبيه سريعة في حال فشل الاتصال بالشبكة
      Get.snackbar(
        "خطأ في الاتصال",
        "تعذر جلب معلومات الشركة، يرجى التحقق من الإنترنت وإعادة المحاولة",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      statusRequest = StatusRequest.none;
    }
    update();
    print(
        "****goToCompanyProfile****StudentSuggestionsControllerImp****************** *-*-* $statusRequest");
  }
  //---------

  @override
  goToSendRequestToCustomer(freelancerPostModel) {
    // Get.toNamed(AppRoute.sendRequestToCustomer);
    Get.to(
        () => SendRequestToCustomer(freelancerPostModel: freelancerPostModel));
  }

  @override
  void goToCustomerProfile(customerId) async {
    // البحث في قائمة بروفايلات الشركات عن الشركة التي تملك نفس الاسم
    // CustomerProfileModel? customerData = customerProfileList.firstWhere(
    //   (element) => element.name == customerName,
    //   orElse: () => customerProfileList[0], // قيمة افتراضية في حال عدم الوجود
    // );

    // Get.to(() => CustomerProfile(
    //       customer: customerData,
    //       isMine: false, // لأن الزائر طالب وليس صاحب الشركة
    //     ));
    Get.dialog(
      const Center(
        child: Card(
          elevation: 4,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: CircularProgressIndicator(
              color:
                  AppColor.primaryColor, // المؤشر الأخضر الدائري المعتمد لديك
            ),
          ),
        ),
      ),
      barrierDismissible:
          false, // يمنع إغلاق الديالوغ بالضغط خارجاً لضمان عدم مقاطعة العملية
    );

    statusRequest1 = StatusRequest.loading;
    print(
        "=====goToCustomerProfile=========StudentSuggestionsControllerImp================-*-Controller $statusRequest1 ");
    // update();

    // استدعاء دالة جلب معلومات الشركة بالـ ID الفعلي
    var response = await studentData.getCustomerDataById(
        customerId, myServices.sharedPreferences.getString("token")!);

    print(
        "=====goToCustomerProfile=========StudentSuggestionsControllerImp======= The Response ===========* Controller $response ");
    statusRequest1 = handlingData(response);
    // 3. إغلاق ديالوغ التحميل فوراً عند انتهاء عملية الاتصال بالسيرفر (سواءً نجحت أو فشلت)
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }

    if (StatusRequest.success == statusRequest1) {
      if (response['data'] != null) {
        // تعبئة البيانات في الموديل بنجاح وبشكل مباشر
        customerProfileModel = CustomerProfileModel.fromJson(response['data']);

        // الانتقال لصفحة البروفايل وتمرير الموديل
        Get.to(() => CustomerProfile(
              customer: customerProfileModel!,
              isMine: false, // الزائر طالب
            ));
      } else {
        statusRequest1 = StatusRequest.none;
      }
    } else {
      statusRequest1 = StatusRequest.none;
      // إظهار رسالة تنبيه سريعة في حال فشل الاتصال بالشبكة
      Get.snackbar(
        "خطأ في الاتصال",
        "تعذر جلب معلومات العميل، يرجى التحقق من الإنترنت وإعادة المحاولة",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      statusRequest1 = StatusRequest.none;
    }
    update();
    print(
        "****goToCustomerProfile****StudentSuggestionsControllerImp****************** *-*-* $statusRequest1");
  }

  @override
  makeSuggestionsPosts() {
    suggestionsAds.clear(); // تفريغ القائمة القديمة

    // أخذ عينة من الشركات (مثلاً أول 3 أو نصف القائمة)
    if (homeController.allCompaniesAds.isNotEmpty) {
      suggestionsAds.addAll(homeController.allCompaniesAds.take(5));
    }

    // أخذ عينة من العملاء
    if (homeController.allCustomersAds.isNotEmpty) {
      suggestionsAds.addAll(homeController.allCustomersAds.take(5));
    }

    // حركة احترافية: خلط العناصر لتظهر بشكل عشوائي كمقترحات
    suggestionsAds.shuffle();

    // تحديث حالة الـ Expanded بناءً على طول القائمة الجديدة
    isExpanded = List.filled(suggestionsAds.length, false);

    update(); // تحديث الواجهة
  }
}
