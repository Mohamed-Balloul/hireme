// import 'package:hireme/core/constant/routes.dart';
import 'package:flutter/material.dart'; // استيراد ويدجت فلاتر الأساسية
import 'package:hireme/controller/student/studenthome_controller.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/core/services/services.dart';
import 'package:hireme/data/datasource/remote/student/student.dart';
// import 'package:hireme/data/datasource/static/static.dart';
import 'package:get/get.dart';
import 'package:hireme/data/model/companiespostmodel.dart';
import 'package:hireme/data/model/companyprofilemodel.dart';
import 'package:hireme/view/screen/company/companyprofile.dart';
import 'package:hireme/view/screen/student/sendrequesttocompany.dart';

abstract class CompaniesPostsController extends GetxController {
  // goToPostDetails(CompanyPostModel companyPostModel);
  goToSendRequestToCompany(CompaniesPostModel companiesPostModel);
  goToCompanyProfile(String companyId);
  action(int index);
  change(int index);
  //--
  getAllCompaniesPosts();
}

class CompaniesPostsControllerImp extends CompaniesPostsController {
  StudentHomeControllerImp homeController =
      Get.find<StudentHomeControllerImp>();
  //--ربط
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  StudentData studentData = StudentData(Get.find());

  CompanyProfileModel? companyProfileModel;

  //--ربط
  int currentIndex = 0;
  //--
  List<CompaniesPostModel> allCompaniesPosts = [];
  //--
  // متغير للتحكم في حالة الفتح والإغلاق

  List<bool>? isExpanded = [];
  @override
  void onInit() {
    getAllCompaniesPosts(); // استدعاء البيانات فوراً عند فتح الصفحة
    super.onInit();
    // for (int i = 0; i < allcompaniesPosts.length; i++) {
    //   isExpanded!.add(false);
    // }
  }

  @override
  getAllCompaniesPosts() {
    // جلب البيانات الحقيقية من الهوم كنترولر
    allCompaniesPosts = homeController.allCompaniesAds;

    // تهيئة قائمة "عرض المزيد" بناءً على عدد البيانات الحقيقية المجلوبة
    isExpanded = List.generate(allCompaniesPosts.length, (index) => false);

    update(); // تحديث الواجهة
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
    // // البحث في قائمة بروفايلات الشركات عن الشركة التي تملك نفس الاسم
    // CompanyProfileModel? companyData = companyProfileList.firstWhere(
    //   (element) => element.name == companyName,
    //   orElse: () => companyProfileList[0], // قيمة افتراضية في حال عدم الوجود
    // );

    // Get.to(() => CompanyProfile(
    //       company: companyData,
    //       isMine: false, // لأن الزائر طالب وليس صاحب الشركة
    //     ));
    // 1. إظهار ديالوغ التحميل الفاخر فوراً لمنع تفاعل المستخدم مع الشاشة ريثما يكتمل الطلب
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
        "=====goToCompanyProfile=========CompaniesPostsControllerImp================-*-Controller $statusRequest ");
    // update();

    // استدعاء دالة جلب معلومات الشركة بالـ ID الفعلي
    var response = await studentData.getCompanyDataById(
        companyId, myServices.sharedPreferences.getString("token")!);

    print(
        "=====goToCompanyProfile=========CompaniesPostsControllerImp======= The Response ===========* Controller $response ");
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
        "****goToCompanyProfile****CompaniesPostsControllerImp****************** *-*-* $statusRequest");
  }
}
