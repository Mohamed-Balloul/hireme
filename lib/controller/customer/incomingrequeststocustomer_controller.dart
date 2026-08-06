import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/customer/customerhome_controller.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/core/services/services.dart';
import 'package:hireme/data/datasource/remote/customer/customer.dart';
// import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/data/model/IncomingRequestsToCustomerModel.dart';
import 'package:hireme/data/model/studentprofilemodel.dart';
import 'package:hireme/view/screen/student/studentprofile.dart';

abstract class IncomingRequestsToCustomerController extends GetxController {
  goToPostDetails();
  goToStudentProfile(String studentId);
  //ربط
  getApplications(int projectId);
  // الدالة الجديدة هنا
  Future<void> refreshData();
  //--
  //
  acceptApplication(String applicationId);
  rejectApplication(String applicationId);
}

class IncomingRequestsToCustomerControllerImp
    extends IncomingRequestsToCustomerController {
  CustomerHomeControllerImp controller = Get.find<CustomerHomeControllerImp>();
  //--ربط
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();

  CustomerData customerData = CustomerData(Get.find());

  List<IncomingRequestsToCustomerModel> applications = [];

  StudentProfileModel? studentProfileModel;
  //--ربط
  @override
  Future<void> refreshData() async {
    // await getCompanyData();
    // await getAllStudents();
    await getApplications(controller.selectedProject);
    update(); // تحديث واجهة المستخدم بعد تحديث البيانات
  }

  //--
  //ربط
  @override
  rejectApplication(applicationId) async {
    statusRequest = StatusRequest.loading;
    print(
        "=========rejectApplication==========IncomingRequestsToCompanyController===========-*-Controller $statusRequest ");
    update();

    String token = myServices.sharedPreferences.getString("token") ?? "";
    var response = await customerData.rejectApplication(token, applicationId);

    print(
        "=========rejectApplication=======IncomingRequestsToCompanyController==============* Controller $response ");
    print(
        "========rejectApplication=========IncomingRequestsToCompanyController=============--Controller $statusRequest ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response["message"] == "Application rejected successfully.") {
        // بعد رفض الطلب، يمكنك تحديث قائمة الطلبات الواردة
        await getApplications(controller.selectedProject);
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
    var response = await customerData.acceptApplication(token, applicationId);

    print(
        "=========acceptApplication=======IncomingRequestsToCompanyController==============* Controller $response ");
    print(
        "========acceptApplication=========IncomingRequestsToCompanyController=============--Controller $statusRequest ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response["message"] == "Application accepted successfully.") {
        // بعد قبول الطلب، يمكنك تحديث قائمة الطلبات الواردة
        await getApplications(controller.selectedProject);
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

  //--

  //ربط
  @override
  getApplications(projectId) async {
    statusRequest = StatusRequest.loading;
    print(
        "=========getApplications==========IncomingRequestsToCustomerController===========-*-Controller $statusRequest ");
    update();

    String token = myServices.sharedPreferences.getString("token") ?? "";

    print("-----projectID----*- *- *- * -* --$projectId");
    print("-----token----*- *- *- * -* --$token");
    var response =
        await customerData.getApplications(token, projectId.toString());

    print(
        "=========getApplications=======IncomingRequestsToCustomerController==============* Controller $response ");
    print(
        "========getApplications=========IncomingRequestsToCustomerController=============--Controller $statusRequest ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response["data"] != null) {
        // تفريغ القائمة قبل الإضافة لتجنب التكرار عند تحديث الصفحة
        applications.clear();

        // تحويل القائمة القادمة من السيرفر إلى موديلات وإضافتها
        List responseData = response['data'];
        applications.addAll(responseData
            .map((e) => IncomingRequestsToCustomerModel.fromJson(e)));
      } else {
        // Get.defaultDialog(
        //   title: "warning",
        //   middleText: "email or password is wrong, try again",
        // );
        statusRequest = StatusRequest.failure;
      }
      // End
    } else {}
    update();
    print(
        "*******getApplications*********IncomingRequestsToCustomerController********** *-*-* $statusRequest");
  }

  @override
  void onInit() {
    getApplications(controller.selectedProject);
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
    //       isCompany: false,
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
        "=====goToStudentProfile=========IncomingRequestsToCustomerControllerImp================-*-Controller $statusRequest ");
    // update();

    // استدعاء دالة جلب معلومات الشركة بالـ ID الفعلي
    var response = await customerData.getStudentDataById(
        studentId, myServices.sharedPreferences.getString("token")!);

    print(
        "=====goToStudentProfile=========IncomingRequestsToCustomerControllerImp======= The Response ===========* Controller $response ");
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
        "****goToStudentProfile****IncomingRequestsToCustomerControllerImp****************** *-*-* $statusRequest");
  }
}
