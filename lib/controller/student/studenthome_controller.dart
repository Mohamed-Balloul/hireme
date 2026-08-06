// import 'package:hireme/controller/company/freelancerposts_controller.dart';
import 'package:flutter/material.dart';
import 'package:hireme/controller/student/companiesposts_controller.dart';
import 'package:hireme/controller/student/freelancerposts_controller.dart';
import 'package:hireme/controller/student/studentsearch_controller.dart';
import 'package:hireme/controller/student/studentsuggestions_controller.dart';
import 'package:hireme/controller/student/thebottomnavigationbar/thebottomnavigationbar_controller.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/core/constant/routes.dart';
import 'package:get/get.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/core/services/services.dart';
import 'package:hireme/data/datasource/remote/auth/logout.dart';
import 'package:hireme/data/datasource/remote/student/notifications.dart';
import 'package:hireme/data/datasource/remote/student/student.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/data/model/companiespostmodel.dart';
import 'package:hireme/data/model/freelancerpostmodel.dart';
import 'package:hireme/data/model/studentprofilemodel.dart';
import 'package:hireme/view/screen/student/savedposts.dart';
import 'package:hireme/view/screen/student/showonecompanypost.dart';
import 'package:hireme/view/screen/student/showonefreelancerpost.dart';
import 'package:hireme/view/screen/student/studentprofile.dart';
import 'package:hireme/view/screen/student/studentsearch.dart';

abstract class StudentHomeController extends GetxController {
  goToCompaniesPosts();
  goToOneCompanyPost(CompaniesPostModel companiesPostModel);
  goToOneFreelancerPost(FreelancerPostModel freelancerPostModel);
  goToFreelancerPosts();
  goToMyProfile();
  goToCustomer();
  action(int index);
  change(int index);
  onChange(int index);
  goToSearchPage();
  goToSavedPosts();
  logout();
  //--
  getStudentData();
  getAllCompaniesAds();
  getAllCustomersAds();
  // الدالة الجديدة هنا
  // Future<void> refreshData();
}

class StudentHomeControllerImp extends StudentHomeController {
  //--ربط
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  LogoutData logoutData = LogoutData(Get.find());
  StudentData studentData = StudentData(Get.find());
  NotificationData notificationData = NotificationData(Get.find());
  StudentProfileModel? studentModel;
  List<CompaniesPostModel> allCompaniesAds = [];
  List<FreelancerPostModel> allCustomersAds = [];
  //--ربط
  int currentIndex = 0;
  int currentIndx = 0;
  // متغير للتحكم في حالة الفتح والإغلاق

  Future<void> refreshData() async {
    // await getCustomerData();
    if (Get.isRegistered<StudentBottomNavigationBarrControllerImp>()) {
      Get.find<StudentBottomNavigationBarrControllerImp>().getData();
    }
    await getAllCompaniesAds();
    await getAllCustomersAds();
    await getStudentData();
    update();
  }

  List<bool>? isExpanded = [];
  @override
  goToCompaniesPosts() {
    Get.toNamed(AppRoute.companiesPosts);
  }

  @override
  goToFreelancerPosts() {
    Get.toNamed(AppRoute.freelancerPosts);
  }

  // @override
  // Future<void> refreshData() async {
  //   await getAllCompaniesAds();
  //   await getAllCustomersAds();
  //   update(); // تحديث واجهة المستخدم بعد تحديث البيانات
  // }

  @override
  goToMyProfile() {
    // Get.toNamed(AppRoute.companyBottomNavigationBarPage);
    Get.to(() => StudentProfile(
          // student: studentProfileList[0],
          student: studentModel!,
          isCompany: false,
          isMine: true,
        ));
  }

  @override
  getAllCustomersAds() async {
    statusRequest = StatusRequest.loading;
    print(
        "====getAllCustomersAds==========StudentHomeControllerImp================-*-Controller $statusRequest ");
    update();
    // بعد ما ينجح الـ API call
    // await Future.delayed(const Duration(seconds: 5)); // أضف هذا السطر
    // ثم انتقل لصفحة الـ

    var response = await studentData.getAllCustomersAds();

    print(
        "=====getAllCustomersAds======StudentHomeControllerImp===================* Controller $response ");
    print(
        "=====getAllCustomersAds====StudentHomeControllerImp=====================--Controller $statusRequest ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response["data"] != null) {
        // allCompaniesAds!.add(CompaniesPostModel.fromJson(response['data']));
        // تفريغ القائمة قبل الإضافة لتجنب التكرار عند تحديث الصفحة
        allCustomersAds!.clear();

        // تحويل القائمة القادمة من السيرفر إلى موديلات وإضافتها
        List responseData = response['data'];
        allCustomersAds!
            .addAll(responseData.map((e) => FreelancerPostModel.fromJson(e)));
        // بعد النجاح، نحدث المقترحات إذا كان الكنترولر موجوداً
        // if (Get.isRegistered<StudentSuggestionsControllerImp>()) {
        //   Get.find<StudentSuggestionsControllerImp>().makeSuggestionsPosts();
        // }
        _updateSuggestions();
        _updateSearch();
        if (Get.isRegistered<FreelancerPostsControllerImp>()) {
          Get.find<FreelancerPostsControllerImp>().getAllCustomersPosts();
        } // استدعاء دالة تحديث المقترحات
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
        "*****getAllCustomersAds******StudentHomeControllerImp*************** *-*-* $statusRequest");
  }

  @override
  getAllCompaniesAds() async {
    statusRequest = StatusRequest.loading;
    print(
        "=====getAllCompaniesAds=======StudentHomeControllerImp==================-*-Controller $statusRequest ");
    update();
    // بعد ما ينجح الـ API call
    // await Future.delayed(const Duration(seconds: 5)); // أضف هذا السطر
    // ثم انتقل لصفحة الـ

    var response = await studentData.getAllCompaniesAds();

    print(
        "=====getAllCompaniesAds=======StudentHomeControllerImp==================* Controller $response ");
    print(
        "=====getAllCompaniesAds======StudentHomeControllerImp===================--Controller $statusRequest ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response["data"] != null) {
        // allCompaniesAds!.add(CompaniesPostModel.fromJson(response['data']));
        // تفريغ القائمة قبل الإضافة لتجنب التكرار عند تحديث الصفحة
        allCompaniesAds!.clear();

        // تحويل القائمة القادمة من السيرفر إلى موديلات وإضافتها
        List responseData = response['data'];
        allCompaniesAds!
            .addAll(responseData.map((e) => CompaniesPostModel.fromJson(e)));
        _updateSuggestions(); // استدعاء دالة تحديث المقترحات
        _updateSearch();
        if (Get.isRegistered<CompaniesPostsControllerImp>()) {
          Get.find<CompaniesPostsControllerImp>().getAllCompaniesPosts();
        }
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
        "****getAllCompaniesAds******StudentHomeControllerImp**************** *-*-* $statusRequest");
  }

  // دالة مساعدة لتجنب تكرار الكود
  void _updateSuggestions() {
    if (Get.isRegistered<StudentSuggestionsControllerImp>()) {
      Get.find<StudentSuggestionsControllerImp>().makeSuggestionsPosts();
    }
  }

  // دالة مساعدة لتجنب تكرار الكود
  void _updateSearch() {
    if (Get.isRegistered<StudentSearchControllerImp>()) {
      Get.find<StudentSearchControllerImp>().getAllAdsAndProjects();
    }
  }

  @override
  getStudentData() async {
    statusRequest = StatusRequest.loading;
    print(
        "=====getStudentData=========StudentHomeControllerImp================-*-Controller $statusRequest ");
    update();
    // بعد ما ينجح الـ API call
    // await Future.delayed(const Duration(seconds: 5)); // أضف هذا السطر
    // ثم انتقل لصفحة الـ

    var response = await studentData.getStudentData(
        myServices.sharedPreferences.getString("user_id")!,
        myServices.sharedPreferences.getString("token")!);

    print(
        "=====getStudentData=========StudentHomeControllerImp======= The Response ===========* Controller $response ");
    print(
        "=====getStudentData=========StudentHomeControllerImp=====================--Controller $statusRequest ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['data'] != null) {
        // data.addAll(response['data']);
        studentModel = StudentProfileModel.fromJson(response['data']);
        //*
        // استخراج البيانات الهامة من الرد
        // var responseData = response['data'];
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
        "****getStudentData****StudentHomeControllerImp****************** *-*-* $statusRequest");
  }

  @override
  void onInit() {
    getStudentData();
    getAllCompaniesAds();
    getAllCustomersAds();

    super.onInit();
    for (int i = 0; i < allcompaniesPosts.length; i++) {
      isExpanded!.add(false);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  goToCustomer() {
    Get.toNamed(AppRoute.customerBottomNavigationBarPage);
  }

  @override
  action(int index) {
    isExpanded![index] = !isExpanded![index];
    update();
  }

  @override
  change(index) {
    currentIndex = index;
    update();
  }

  @override
  onChange(index) {
    currentIndx = index;
    update();
  }

  @override
  goToOneCompanyPost(companiesPostModel) {
    Get.to(() => ShowOneCompanyPost(companiesPostModel: companiesPostModel));
  }

  @override
  goToOneFreelancerPost(freelancerPostModel) {
    Get.to(
        () => ShowOneFreelancerPost(freelancerPostModel: freelancerPostModel));
  }

  @override
  goToSearchPage() {
    Get.to(() => StudentSearch());
  }

  @override
  goToSavedPosts() {
    Get.to(() => SavedPosts());
  }

  //ربط
  // @override
  // logout() {
  //   Get.defaultDialog(
  //     title: "تأكيد تسجيل الخروج",
  //     middleText: "هل أنت متأكد أنك تريد تسجيل الخروج؟",
  //     textCancel: "إلغاء",
  //     textConfirm: "تأكيد",
  //     onConfirm: () async {
  //       // هنا يمكنك استدعاء دالة تسجيل الخروج من الـ Controller الخاص بك
  //       // مثلاً:
  //       // authController.logout();
  //       // Get.offAllNamed(AppRoute.login);
  //       statusRequest = StatusRequest.loading;
  //       print(
  //           "=====logout========StudentHomeControllerImp=================-*-Controller $statusRequest ");
  //       update();
  //       // 1. جلب التوكن من الـ SharedPreferences
  //       String token = myServices.sharedPreferences.getString("token") ?? "";
  //       String? deviceId =
  //           myServices.sharedPreferences.getString("device_record_id");

  //       // بعد ما ينجح الـ API call
  //       // await Future.delayed(const Duration(seconds: 5)); // أضف هذا السطر
  //       // الخطوة 1: حذف الجهاز من السيرفر (Push Notification Cleanup)
  //       if (deviceId != null) {
  //         await notificationData.deleteDevice(token, deviceId);
  //       }
  //       // ثم انتقل لصفحة الـ
  //       // الخطوة 2: تسجيل الخروج الرسمي من الحساب

  //       var response = await logoutData.postData(token);

  //       print(
  //           "===logout=======StudentHomeControllerImp====================* Controller $response ");
  //       print(
  //           "====logout======StudentHomeControllerImp====================--Controller $statusRequest ");

  //       statusRequest = handlingData(response);

  //       if (StatusRequest.success == statusRequest) {
  //         // Start backend
  //         // if (response['status'] == "success") {
  //         if (response['message'] == "Logged out successfully.") {
  //           // data.addAll(response['data']);
  //           // Get.offNamed(AppRoute.verfiyCodeSignUp,
  //           //     arguments: {"email": email.text});
  //           // 3. الخطوة الأهم: حذف البيانات محلياً
  //           myServices.sharedPreferences
  //               .clear(); // أو احذف فقط التوكن والـ step
  //           // 4. الانتقال لصفحة تسجيل الدخول ومنع الرجوع للخلف
  //           Get.offAllNamed(AppRoute.login);
  //         } else {
  //           Get.defaultDialog(
  //             title: "warning",
  //             middleText: "wrong logout",
  //           );
  //           statusRequest = StatusRequest.none;
  //         }
  //         // End
  //       } else {
  //         // حتى لو فشل السيرفر، يفضل تسجيل الخروج محلياً لضمان تجربة مستخدم جيدة
  //         // myServices.sharedPreferences.clear();
  //         // Get.offAllNamed(AppRoute.login);
  //         print("logout failed: $response");
  //         Get.defaultDialog(
  //           title: "خطأ",
  //           middleText:
  //               "تعذر تسجيل الخروج، يرجى التحقق من الإنترنت والمحاولة مجدداً.",
  //         );
  //         statusRequest = StatusRequest.none;
  //       }
  //       update();
  //       print(
  //           "****logout******StudentHomeControllerImp****************** *-*-* $statusRequest");
  //     },
  //   );
  // }
  // داخل كلاس StudentHomeControllerImp:

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
            "=====logout========StudentHomeControllerImp=================-*-Controller $statusRequest ");
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
            "===logout=======StudentHomeControllerImp====================* Response: $response ");
        statusRequest = handlingData(response);

        if (StatusRequest.success == statusRequest) {
          if (response['message'] == "Logged out successfully.") {
            // نجاح كامل: مسح البيانات محلياً والتحويل لصفحة تسجيل الدخول
            // myServices.sharedPreferences.clear();
            //--
            // استبدل سطر myServices.sharedPreferences.clear() بداخل دوال الـ logout بالتالي لتجربة مستخدم أفضل:

            myServices.sharedPreferences
                .setString("step", "1"); // نعيده للخطوة 1 (مستعد لتسجيل الدخول)
            myServices.sharedPreferences
                .remove("token"); // حذف التوكن لحماية الحساب
            myServices.sharedPreferences
                .remove("user_id"); // حذف معرّف المستخدم
            myServices.sharedPreferences.remove("role"); // حذف نوع الحساب
            //--
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
            "****logout******StudentHomeControllerImp****************** *-*-* $statusRequest");
      },
    );
  }
  //ربط
}
