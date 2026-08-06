import 'package:flutter/material.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/core/services/services.dart';
import 'package:hireme/data/datasource/remote/student/student.dart';
// import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/data/model/companypostmodel.dart';
import 'package:get/get.dart';
import 'package:hireme/data/model/companyprofilemodel.dart';
import 'package:hireme/data/model/customerprofilemodel.dart';
import 'package:hireme/data/model/myrequesttocompanymodel.dart';
import 'package:hireme/data/model/myrequesttocustomermodel.dart';
import 'package:hireme/view/screen/company/companyprofile.dart';
import 'package:hireme/view/screen/customer/customerprofile.dart';
// import 'package:hireme/view/screen/student/companypostdetails.dart';

abstract class MyOrdersController extends GetxController {
  goToPostDetails(CompanyPostModel companyPostModel);
  goToCompanyProfile(String companyId);
  goToCustomerProfile(String customerId);
  deleteOrder(int id, bool isCompany);
  printHi();
  //--ربط
  getAllMyAdApplications();
  getAllMyProjectApplications();
  //--
  deleteMyAdApplication(String id);
  deleteMyProjectApplication(String id);

  // الدالة الجديدة هنا
  Future<void> refreshData();
}

class MyOrdersControllerImp extends MyOrdersController {
  //--ربط
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  StudentData studentData = StudentData(Get.find());
  List<MyRequestToCompanyModel> allMyAdApplications = [];
  List<MyRequestToCustomerModel> allMyProjectApplications = [];
  CompanyProfileModel? companyProfileModel;
  CustomerProfileModel? customerProfileModel;

  //--ربط
  // القائمة التي يتم عرضها
  // List<MyRequestToCompanyModel> get myAllRequestsToCompaniesList {
  //   /*if (selectedFilter == "الكل")*/ return myRequestsToCompaniesList;
  //   // return allNotifications.where((n) => n.type == selectedFilter).toList();
  // }

  // القائمة التي يتم عرضها
  // List<MyRequestToCustomerModel> get myAllRequestsToCustomersList {
  //   /*if (selectedFilter == "الكل")*/ return myRequestsToCustomersList;
  //   // return allNotifications.where((n) => n.type == selectedFilter).toList();
  // }
  //ربط
  @override
  Future<void> refreshData() async {
    // await getCompanyData();
    // await getAllStudents();
    await getAllMyAdApplications();
    await getAllMyProjectApplications();
    update(); // تحديث واجهة المستخدم بعد تحديث البيانات
  }
  //ربط

  @override
  getAllMyAdApplications() async {
    statusRequest = StatusRequest.loading;
    print(
        "=====getAllMyAdApplications============MyOrdersControllerImp=============-*-Controller $statusRequest ");
    update();

    // بعد ما ينجح الـ API call
    // await Future.delayed(const Duration(seconds: 5)); // أضف هذا السطر
    // ثم انتقل لصفحة الـ

    var response = await studentData.getAllMyAdApplications(
        myServices.sharedPreferences.getString("token")!);

    print(
        "=====getAllMyAdApplications=============MyOrdersControllerImp============* Controller $response ");
    print(
        "=====getAllMyAdApplications=============MyOrdersControllerImp============--Controller $statusRequest ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response["data"] != null) {
        // allCompaniesAds!.add(CompaniesPostModel.fromJson(response['data']));
        // تفريغ القائمة قبل الإضافة لتجنب التكرار عند تحديث الصفحة
        allMyAdApplications!.clear();

        // تحويل القائمة القادمة من السيرفر إلى موديلات وإضافتها
        List responseData = response['data'];
        allMyAdApplications!.addAll(
            responseData.map((e) => MyRequestToCompanyModel.fromJson(e)));
        //--
        //     allMyAdApplications.clear(); // إزالة الـ ! هنا

        // List responseData = response['data'];
        // // تحويل البيانات وإضافتها للقائمة
        // allMyAdApplications.addAll(
        //     responseData.map((e) => MyRequestToCompanyModel.fromJson(e)).toList()
        // );
        //--
        // _updateSuggestions(); // استدعاء دالة تحديث المقترحات
        // if (Get.isRegistered<CompaniesPostsControllerImp>()) {
        //   Get.find<CompaniesPostsControllerImp>().getAllCompaniesPosts();
        // }
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
        "****getAllMyAdApplications*************MyOrdersControllerImp********* *-*-* $statusRequest");
  }

  //ربط
  @override
  getAllMyProjectApplications() async {
    statusRequest = StatusRequest.loading;
    print(
        "=====getAllMyProjectApplications=========================-*-Controller $statusRequest ");
    update();
    // بعد ما ينجح الـ API call
    // await Future.delayed(const Duration(seconds: 5)); // أضف هذا السطر
    // ثم انتقل لصفحة الـ

    var response = await studentData.getAllMyProjectApplications(
        myServices.sharedPreferences.getString("token")!);

    print(
        "=====getAllMyProjectApplications=========================* Controller $response ");
    print(
        "=====getAllMyProjectApplications=========================--Controller $statusRequest ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response["data"] != null) {
        // allCompaniesAds!.add(CompaniesPostModel.fromJson(response['data']));
        // تفريغ القائمة قبل الإضافة لتجنب التكرار عند تحديث الصفحة
        allMyProjectApplications!.clear();

        // تحويل القائمة القادمة من السيرفر إلى موديلات وإضافتها
        List responseData = response['data'];
        allMyProjectApplications!.addAll(
            responseData.map((e) => MyRequestToCustomerModel.fromJson(e)));
        // _updateSuggestions(); // استدعاء دالة تحديث المقترحات
        // if (Get.isRegistered<CompaniesPostsControllerImp>()) {
        //   Get.find<CompaniesPostsControllerImp>().getAllCompaniesPosts();
        // }
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
        "****getAllMyProjectApplications********************** *-*-* $statusRequest");
  }

  //ربط
  @override
  deleteMyAdApplication(id) async {
    statusRequest = StatusRequest.loading;
    print(
        "=====deleteMyAdApplication=========================-*-Controller $statusRequest ");
    print("=====deleteMyAdApplication====== id = $id =================== ");
    update();

    var response = await studentData.deleteMyAdApplication(
        id, myServices.sharedPreferences.getString("token")!);

    print(
        "=====deleteMyAdApplication=========================* Controller $response ");
    print(
        "=====deleteMyAdApplication=========================--Controller $statusRequest ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response["message"] == "Ad application deleted successfully.") {
        // إزالة  من القائمة محلياً لتحديث الواجهة فوراً
        allMyAdApplications
            .removeWhere((application) => application.id.toString() == id);
        update();
        Get.snackbar(
          "نجاح",
          "تم الحذف بنجاح",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "خطأ",
          "فشل الحذف، يرجى المحاولة لاحقاً.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
        );
      }
      // End
    } else {
      Get.snackbar(
        "خطأ",
        "فشل الاتصال بالسيرفر، يرجى المحاولة لاحقاً.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
    update();
    print(
        "****deleteMyAdApplication********************** *-*-* $statusRequest");
  }

  //ربط
  @override
  deleteMyProjectApplication(id) async {
    statusRequest = StatusRequest.loading;
    print(
        "===========deleteMyProjectApplication===================-*-Controller $statusRequest ");
    update();
    // بعد ما ينجح الـ API call
    // await Future.delayed(const Duration(seconds: 5)); // أضف هذا السطر
    // ثم انتقل لصفحة الـ

    var response = await studentData.deleteMyProjectApplication(
        id, myServices.sharedPreferences.getString("token")!);

    print(
        "====deleteMyProjectApplication=========================* Controller $response ");
    print(
        "========deleteMyProjectApplication======================--Controller $statusRequest ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response["message"] == "Project application deleted successfully.") {
        // إزالة  من القائمة محلياً لتحديث الواجهة فوراً
        allMyProjectApplications
            .removeWhere((application) => application.id.toString() == id);
        update();
        Get.snackbar(
          "نجاح",
          "تم الحذف بنجاح",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "خطأ",
          "فشل الحذف، يرجى المحاولة لاحقاً.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
        );
      }
      // End
    } else {
      Get.snackbar(
        "خطأ",
        "فشل الاتصال بالسيرفر، يرجى المحاولة لاحقاً.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
    update();
    print(
        "****deleteMyProjectApplication********************** *-*-* $statusRequest");
  }

  @override
  void onInit() {
    getAllMyAdApplications();
    getAllMyProjectApplications();
    super.onInit();
  }

  @override
  goToPostDetails(companyPostModel) {}
  @override
  void goToCompanyProfile(companyId) async {
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
        "=====goToCompanyProfile=========MyOrdersControllerImp================-*-Controller $statusRequest ");
    // update();

    // استدعاء دالة جلب معلومات الشركة بالـ ID الفعلي
    var response = await studentData.getCompanyDataById(
        companyId, myServices.sharedPreferences.getString("token")!);

    print(
        "=====goToCompanyProfile=========MyOrdersControllerImp======= The Response ===========* Controller $response ");
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
        "****goToCompanyProfile****MyOrdersControllerImp****************** *-*-* $statusRequest");
  }

  @override
  void goToCustomerProfile(customerId) async {
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
        "=====goToCustomerProfile=========MyOrdersControllerImp================-*-Controller $statusRequest ");
    // update();

    // استدعاء دالة جلب معلومات الشركة بالـ ID الفعلي
    var response = await studentData.getCustomerDataById(
        customerId, myServices.sharedPreferences.getString("token")!);

    print(
        "=====goToCustomerProfile=========MyOrdersControllerImp======= The Response ===========* Controller $response ");
    statusRequest = handlingData(response);
    // 3. إغلاق ديالوغ التحميل فوراً عند انتهاء عملية الاتصال بالسيرفر (سواءً نجحت أو فشلت)
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }

    if (StatusRequest.success == statusRequest) {
      if (response['data'] != null) {
        // تعبئة البيانات في الموديل بنجاح وبشكل مباشر
        customerProfileModel = CustomerProfileModel.fromJson(response['data']);

        // الانتقال لصفحة البروفايل وتمرير الموديل
        Get.to(() => CustomerProfile(
              customer: customerProfileModel!,
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
        "تعذر جلب معلومات العميل، يرجى التحقق من الإنترنت وإعادة المحاولة",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      statusRequest = StatusRequest.none;
    }
    update();
    print(
        "****goToCustomerProfile****MyOrdersControllerImp****************** *-*-* $statusRequest");
  }

  @override
  printHi() {
    print("hi");
  }

  @override
  deleteOrder(id, isCompany) {
    // isCompany
    //     ? myRequestsToCompaniesList.removeWhere((element) => element. == id)
    //     : myRequestsToCustomersList.removeWhere((element) => element.id == id);
    String id1 = id.toString();
    isCompany ? deleteMyAdApplication(id1) : deleteMyProjectApplication(id1);
    printHi();
    update();
  }
}
