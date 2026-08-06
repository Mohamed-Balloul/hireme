import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/company/companyhome_controller.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/core/services/services.dart';
import 'package:hireme/data/datasource/remote/company/company.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/data/model/incomingrequeststocompanymodel.dart';
import 'package:hireme/data/model/studentprofilemodel.dart';
import 'package:hireme/view/screen/customer/customerprofile.dart';
import 'package:hireme/view/screen/student/studentprofile.dart';

abstract class IncomingRequestsController extends GetxController {
  goToPostDetails();
  // goToCompanyProfile(String companyName);
  goToStudentProfile(String studentId);
  //ربط
  getApplications(int adId);
  // الدالة الجديدة هنا
  Future<void> refreshData();
  //
  acceptApplication(String applicationId);
  rejectApplication(String applicationId);
}

class IncomingRequestsControllerImp extends IncomingRequestsController {
  CompanyHomeControllerImp controller = Get.find<CompanyHomeControllerImp>();
  //--ربط
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();

  CompanyData companyData = CompanyData(Get.find());

  List<IncomingRequestsToCompanyModel> applications = [];

  StudentProfileModel? studentProfileModel;
  //--ربط
  @override
  Future<void> refreshData() async {
    // await getCompanyData();
    // await getAllStudents();
    await getApplications(controller.selectedAdId);
    update(); // تحديث واجهة المستخدم بعد تحديث البيانات
  }

  //ربط
  @override
  rejectApplication(applicationId) async {
    statusRequest = StatusRequest.loading;
    print(
        "=========rejectApplication==========IncomingRequestsToCompanyController===========-*-Controller $statusRequest ");
    update();

    String token = myServices.sharedPreferences.getString("token") ?? "";
    var response = await companyData.rejectApplication(token, applicationId);

    print(
        "=========rejectApplication=======IncomingRequestsToCompanyController==============* Controller $response ");
    print(
        "========rejectApplication=========IncomingRequestsToCompanyController=============--Controller $statusRequest ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response["message"] == "Application rejected successfully.") {
        // بعد رفض الطلب، يمكنك تحديث قائمة الطلبات الواردة
        await getApplications(controller.selectedAdId);
      } else {
        Get.defaultDialog(
          title: "تنبيه",
          middleText: "تعذر رفض الطلب، يرجى المحاولة لاحقاً",
        );
        statusRequest = StatusRequest.none;
      }
      // End
    } else {}
    update();
    print(
        "*******rejectApplication*********IncomingRequestsToCompanyController********** *-*-* $statusRequest");
  }

  //ربط
  @override
  acceptApplication(applicationId) async {
    statusRequest = StatusRequest.loading;
    print(
        "=========acceptApplication==========IncomingRequestsToCompanyController===========-*-Controller $statusRequest ");
    update();

    String token = myServices.sharedPreferences.getString("token") ?? "";
    var response = await companyData.acceptApplication(token, applicationId);

    print(
        "=========acceptApplication=======IncomingRequestsToCompanyController==============* Controller $response ");
    print(
        "========acceptApplication=========IncomingRequestsToCompanyController=============--Controller $statusRequest ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response["message"] == "Application accepted successfully.") {
        // بعد قبول الطلب، يمكنك تحديث قائمة الطلبات الواردة
        await getApplications(controller.selectedAdId);
      } else {
        Get.defaultDialog(
          title: "تنبيه",
          middleText: "تعذر قبول الطلب، يرجى المحاولة لاحقاً",
        );
        statusRequest = StatusRequest.none;
      }
      // End
    } else {}
    update();
    print(
        "*******acceptApplication*********IncomingRequestsToCompanyController********** *-*-* $statusRequest");
  }

  //ربط
  @override
  getApplications(adId) async {
    statusRequest = StatusRequest.loading;
    print(
        "=========getApplications==========IncomingRequestsToCompanyController===========-*-Controller $statusRequest ");
    update();

    String token = myServices.sharedPreferences.getString("token") ?? "";
    var response = await companyData.getApplications(token, adId.toString());

    print(
        "=========getApplications=======IncomingRequestsToCompanyController==============* Controller $response ");
    print(
        "========getApplications=========IncomingRequestsToCompanyController=============--Controller $statusRequest ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response["data"] != null) {
        // تفريغ القائمة قبل الإضافة لتجنب التكرار عند تحديث الصفحة
        applications.clear();

        // تحويل القائمة القادمة من السيرفر إلى موديلات وإضافتها
        List responseData = response['data'];
        applications.addAll(responseData
            .map((e) => IncomingRequestsToCompanyModel.fromJson(e)));
      } else {
        // Get.defaultDialog(
        //   title: "تنبيه",
        //   middleText: "لا توجد طلبات واردة حالياً",
        // );
        statusRequest = StatusRequest.none;
      }
      // End
    } else {}
    update();
    print(
        "*******getApplications*********IncomingRequestsToCompanyController********** *-*-* $statusRequest");
  }

  //ربط
  @override
  void onInit() {
    getApplications(controller.selectedAdId);
    super.onInit();
  }

  @override
  goToPostDetails() {
    // Get.to(() => CompanyPostDetails(companyPostModel: companyPostModel));
  }

  @override
  void goToStudentProfile(studentId) async {
    // البحث في قائمة بروفايلات الشركات عن الشركة التي تملك نفس الاسم
    // StudentProfileModel? studentData = studentProfileList.firstWhere(
    //   (element) => element.name == studentName,
    //   orElse: () => studentProfileList[0], // قيمة افتراضية في حال عدم الوجود
    // );

    // Get.to(() => StudentProfile(
    //       student: studentData,
    //       isMine: false, // لأن الزائر طالب وليس صاحب الشركة
    //       isCompany: true,
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
        "=====goToStudentProfile=========IncomingRequestsControllerImp================-*-Controller $statusRequest ");
    // update();

    // استدعاء دالة جلب معلومات الشركة بالـ ID الفعلي
    var response = await companyData.getStudentDataById(
        studentId, myServices.sharedPreferences.getString("token")!);

    print(
        "=====goToStudentProfile=========IncomingRequestsControllerImp======= The Response ===========* Controller $response ");
    statusRequest = handlingData(response);
    // 3. إغلاق ديالوغ التحميل فوراً عند انتهاء عملية الاتصال بالسيرفر (سواءً نجحت أو فشلت)
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }

    if (StatusRequest.success == statusRequest) {
      if (response['data'] != null) {
        // تعبئة البيانات في الموديل بنجاح وبشكل مباشر
        studentProfileModel = StudentProfileModel.fromJson(response['data']);

        // الانتقال لصفحة البروفايل وتمرير الموديل
        Get.to(() => StudentProfile(
              student: studentProfileModel!,
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
        "تعذر جلب معلومات الطالب، يرجى التحقق من الإنترنت وإعادة المحاولة",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      statusRequest = StatusRequest.none;
    }
    update();
    print(
        "****goToStudentProfile****IncomingRequestsControllerImp****************** *-*-* $statusRequest");
  }
}
