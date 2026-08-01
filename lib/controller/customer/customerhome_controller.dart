import 'package:flutter/material.dart';
import 'package:hireme/controller/customer/customerbottomnavigationbar/customerbottomnavigationbar_controller.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/core/constant/routes.dart';
import 'package:get/get.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/core/services/services.dart';
import 'package:hireme/data/datasource/remote/auth/logout.dart';
import 'package:hireme/data/datasource/remote/customer/customer.dart';
import 'package:hireme/data/datasource/remote/student/notifications.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/data/model/customerprofilemodel.dart';
import 'package:hireme/data/model/freelancerpostmodel.dart';
import 'package:hireme/data/model/studentprofilemodel.dart';
import 'package:hireme/view/screen/customer/savedstudents.dart';
import 'package:hireme/view/screen/customer/customerprofile.dart';
import 'package:hireme/view/screen/customer/customersearch.dart';
import 'package:hireme/view/screen/student/studentprofile.dart';

abstract class CustomerHomeController extends GetxController {
  goToCustomerPosts();
  goToFreelancerPosts();
  // goToProfile();
  goToCompanyPosts();
  goToIncomingRequests(int selectedProjectId);
  // goToComingRequests();
  goToStudentProfile();
  action(int index);
  onChange(int index);
  goToSearchPage();
  goToMyProfile();
  goToSavedStudents();
  deleteMyPost(int index);
  //--
  logout();
  getCustomerData();
  getAllStudents();
  getMyProjects();
  // الدالة الجديدة هنا
  Future<void> refreshData();
}

class CustomerHomeControllerImp extends CustomerHomeController {
  //--ربط
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  LogoutData logoutData = LogoutData(Get.find());
  CustomerData customerData = CustomerData(Get.find());
  NotificationData notificationData = NotificationData(Get.find());
  CustomerProfileModel? customerModel;
  CustomerBottomNavigationBarrControllerImp controller =
      Get.find<CustomerBottomNavigationBarrControllerImp>();
  List<StudentProfileModel> allStudents = [];
  List<FreelancerPostModel> myProjects = [];
  int selectedProject =
      0; // لتحديد المشروع المختار عند الانتقال لصفحة الطلبات الواردة
  //--ربط
  @override
  Future<void> refreshData() async {
    // await getCustomerData();
    // await getAllStudents();
    await getMyProjects();
    update();
  }

  goToCustomerPosts() {
    Get.toNamed(AppRoute.customerPostsDetails);
  }

  @override
  goToFreelancerPosts() {
    Get.toNamed(AppRoute.customerComingRequests);
  }

  // @override
  // goToProfile() {
  //   Get.toNamed(AppRoute.CompanyProfile);
  // }

  int currentIndex = 0;
  // متغير للتحكم في حالة الفتح والإغلاق

  List<bool>? isExpanded = [];
  @override
  goToCompanyPosts() {
    Get.toNamed(AppRoute.companyPostsDetails);
  }

  @override
  goToComingRequests() {
    Get.toNamed(AppRoute.companyComingRequests);
  }

  // @override
  // goToProfile() {
  //   Get.toNamed(AppRoute.CompanyProfile);
  // }

  @override
  void onInit() {
    getCustomerData();
    getAllStudents();
    getMyProjects();
    super.onInit();
    for (int i = 0; i < customerPosts.length; i++) {
      isExpanded!.add(false);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  action(index) {
    isExpanded![index] = !isExpanded![index];
    update();
  }

// selectedProjectId
  @override
  goToIncomingRequests(selectedProjectId) {
    selectedProject = selectedProjectId;
    Get.toNamed(AppRoute.incomingApplicationsToCustomerScreen);
  }

  @override
  onChange(index) {
    currentIndex = index;
    update();
  }

  @override
  goToStudentProfile() {
    Get.to(() => StudentProfile(
          student: bestStudents[currentIndex], // الطالب المختار من السلايدر
          isMine: false, // الزائر شركة، لذا لا تظهر أزرار التعديل
          isCompany: false,
        ));
  }

  @override
  goToSearchPage() {
    Get.to(() => CustomerSearch());
  }

  @override
  goToMyProfile() {
    Get.to(() => CustomerProfile(
          customer: customerProfileList[0],
          isMine: true,
        ));
  }

  @override
  goToSavedStudents() {
    Get.to(() => SavedStudents());
  }

  @override
  deleteMyPost(index) {
    customerPosts.removeAt(index);
    update();
  }

  //ربط
  @override
  getAllStudents() async {
    statusRequest = StatusRequest.loading;
    print(
        "=========getAllStudents==========CustomerHomeControllerImp===========-*-Controller $statusRequest ");
    update();

    String token = myServices.sharedPreferences.getString("token") ?? "";
    var response = await customerData.getAllStudents(token);

    print(
        "=========getAllStudents=======CustomerHomeControllerImp==============* Controller $response ");
    print(
        "========getAllStudents=========CustomerHomeControllerImp=============--Controller $statusRequest ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response["data"] != null) {
        // تفريغ القائمة قبل الإضافة لتجنب التكرار عند تحديث الصفحة
        allStudents!.clear();

        // تحويل القائمة القادمة من السيرفر إلى موديلات وإضافتها
        List responseData = response['data'];
        allStudents!
            .addAll(responseData.map((e) => StudentProfileModel.fromJson(e)));
        // _updateSuggestions(); //
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
        "*******getAllStudents*********CustomerHomeControllerImp********** *-*-* $statusRequest");
  }

  //ربط
  @override
  getMyProjects() async {
    statusRequest = StatusRequest.loading;
    print(
        "=========getMyProjects==========CustomerHomeControllerImp===========-*-Controller $statusRequest ");
    update();

    String token = myServices.sharedPreferences.getString("token") ?? "";
    var response = await customerData.getMyProjects(token);

    print(
        "=========getMyProjects=======CustomerHomeControllerImp==============* Controller $response ");
    print(
        "========getMyProjects=========CustomerHomeControllerImp=============--Controller $statusRequest ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response["data"] != null) {
        // تفريغ القائمة قبل الإضافة لتجنب التكرار عند تحديث الصفحة
        myProjects!.clear();

        // تحويل القائمة القادمة من السيرفر إلى موديلات وإضافتها
        List responseData = response['data'];
        myProjects!
            .addAll(responseData.map((e) => FreelancerPostModel.fromJson(e)));
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
        "*******getMyProjects*********CustomerHomeControllerImp********** *-*-* $statusRequest");
  }
  //ربط

  @override
  getCustomerData() {
    customerModel = controller.customerModel;
    update();
  }

  @override
  logout() {
    Get.defaultDialog(
      title: "تأكيد تسجيل الخروج",
      middleText: "هل أنت متأكد أنك تريد تسجيل الخروج؟",
      textCancel: "إلغاء",
      textConfirm: "تأكيد",
      confirmTextColor: Colors.white,
      buttonColor: AppColor.primaryColor, // لون الزر الأخضر المعتمد لديك
      onConfirm: () async {
        // 1. إغلاق دايلوج التأكيد فوراً لتجنب النقر المتعدد وإظهار شاشة التحميل بوضوح
        Get.back();

        statusRequest = StatusRequest.loading;
        print(
            "=====logout========CustomerHomeControllerImp=================-*-Controller $statusRequest ");
        update();

        // 2. جلب البيانات المحلية
        String token = myServices.sharedPreferences.getString("token") ?? "";
        String? deviceId =
            myServices.sharedPreferences.getString("device_record_id");

        // 3. الخطوة الأولى: حذف جهاز الإشعارات بشكل محمي تماماً
        if (deviceId != null) {
          try {
            await notificationData.deleteDevice(token, deviceId);
          } catch (e) {
            print("--- خطأ غير مؤثر في حذف توكن الإشعارات: $e");
          }
        }

        // 4. الخطوة الثانية: تسجيل الخروج الرسمي من السيرفر
        var response = await logoutData.postData(token);

        print(
            "===logout=======CustomerHomeControllerImp====================* Response: $response ");
        statusRequest = handlingData(response);

        if (StatusRequest.success == statusRequest) {
          if (response['message'] == "Logged out successfully.") {
            // نجاح كامل: مسح البيانات محلياً والتحويل لصفحة تسجيل الدخول
            myServices.sharedPreferences.clear();
            Get.offAllNamed(AppRoute.login);
          } else {
            // رد غير متوقع من السيرفر: نسجل الخروج محلياً كإجراء دفاعي آمن
            print(
                "رد غير متوقع من السيرفر: نسجل الخروج محلياً كإجراء دفاعي آمن");
            // myServices.sharedPreferences.clear();
            // Get.offAllNamed(AppRoute.login);
          }
        } else {
          // في حال فشل السيرفر أو انقطاع الإنترنت، نقوم بالتنظيف محلياً لضمان خروج العميل وتفادي احتجازه
          print("--- فشل الاتصال بالسيرفر، يتم تسجيل الخروج محلياً الآن.");
          // myServices.sharedPreferences.clear();
          // Get.offAllNamed(AppRoute.login);
        }

        statusRequest = StatusRequest.none;
        update();
        print(
            "****logout******CustomerHomeControllerImp****************** *-*-* $statusRequest");
      },
    );
  }
}
